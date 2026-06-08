import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:yala/data/network/remote/base/base_response.dart';
import 'package:yala/data/network/remote/base/error_response.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:yala/data/network/remote/utils/interfaces/network_info.dart';
import 'package:yala/domain/either/app_failure.dart';
import 'package:yala/domain/either/result.dart';

class NetworkHandler {
  final NetworkInfo networkInfo;

  const NetworkHandler(
    this.networkInfo,
  );

  Future<Result<BaseResponse<T>>> handleServerResponse<T>({
    required Future<Response<Map<String, dynamic>>> Function() task,
    required T? Function(Map<String, dynamic>? json) fromJsonT,
  }) async {
    final isConnected = await networkInfo.isConnected();
    if (!isConnected) {
      return Failure(const FailureNetwork());
    }

    try {
      final response = await task();
      final body = response.data;

      if (body == null) {
        return Failure(const FailureDataNullError());
      }

      final baseResponse = BaseResponse<T>.fromJson(
        json: body,
        fromJsonT: fromJsonT,
        httpStatusFallback: response.statusCode,
      );

      if (baseResponse.isProcessedSuccessfully) {
        return Success(baseResponse);
      }

      return _mapBodyStatusToFailure(baseResponse);
    } on DioException catch (e) {
      return _handleDioException(e);
    } catch (e, stack) {
      return _handleUnknownException(e, stack);
    }
  }

  Future<Result<T>> handleRawResponse<T>({
    required Future<Response<Map<String, dynamic>>> Function() task,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    final isConnected = await networkInfo.isConnected();
    if (!isConnected) {
      return Failure(const FailureNetwork());
    }

    try {
      final response = await task();
      final body = response.data;

      if (body == null) {
        return Failure(const FailureDataNullError());
      }

      return Success(fromJson(body));
    } on DioException catch (e) {
      return _handleDioException(e);
    } catch (e, stack) {
      return _handleUnknownException(e, stack);
    }
  }

  /// HTTP 2xx pero el status del body indica error.
  Failure<T> _mapBodyStatusToFailure<T>(BaseResponse<dynamic> r) {
    final code = r.status ?? 0;
    final message = _concatCodeError(r.message ?? '', code);
    final isBackend = (r.message ?? '').isNotEmpty;
    return Failure(_codeToFailure(code, message, isBackend));
  }

  Failure<T> analyzeResponseFailure<T>({
    required int code,
    required String errorBodyAsString,
  }) {
    ErrorResponse? errorResponse;

    try {
      final decoded = jsonDecode(errorBodyAsString);
      if (decoded is Map<String, dynamic>) {
        errorResponse = ErrorResponse.fromJson(decoded);
      }
    } catch (_) {}

    final message = _concatCodeError(errorResponse?.message ?? '', code);
    final isBackend = (errorResponse?.message ?? '').isNotEmpty;

    // Códigos desconocidos sin body reconocible → FailureNone genérico.
    if (errorResponse == null && !_isKnownCode(code)) {
      return Failure(FailureNone(message: '[$code]'));
    }

    return Failure(_codeToFailure(code, message, isBackend));
  }

  Failure<T> _handleDioException<T>(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => Failure(const FailureTimeout()),

      DioExceptionType.badResponse => _handleBadResponse(e),

      DioExceptionType.cancel => Failure(const FailureJobCancellation()),

      DioExceptionType.connectionError => _handleConnectionError(e),

      _ => _handleUnknownException(e, StackTrace.current),
    };
  }

  Failure<T> _handleBadResponse<T>(DioException e) {
    final code = e.response?.statusCode ?? 0;
    final raw = e.response?.data;
    final body = raw is String ? raw : (raw != null ? jsonEncode(raw) : '');
    return analyzeResponseFailure(code: code, errorBodyAsString: body);
  }

  Failure<T> _handleConnectionError<T>(DioException e) {
    return switch (e.error) {
      SocketException() => Failure(const FailureNetwork()),
      HandshakeException() => Failure(const FailureSecureConnection()),
      _ => Failure(const FailureNetwork()),
    };
  }

  Failure<T> _handleUnknownException<T>(Object e, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(e, stack, printDetails: true);
    return Failure(FailureNone(message: e.toString()));
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Único lugar donde los códigos HTTP se mapean a [AppFailure].
  AppFailure _codeToFailure(int code, String message, bool isBackend) {
    return switch (code) {
      400 => FailureBadRequest(message: message, isBackendMessage: isBackend),
      401 => FailureUnauthorized(message: message, isBackendMessage: isBackend),
      402 => FailureMakePayment(message: message, isBackendMessage: isBackend),
      403 => FailureForbidden(message: message, isBackendMessage: isBackend),
      404 => FailureNotFound(message: message, isBackendMessage: isBackend),
      409 => FailureConflict(message: message, isBackendMessage: isBackend),
      413 => FailurePayloadTooLarge(message: message, isBackendMessage: isBackend),
      500 => FailureDetected(message: message, isBackendMessage: isBackend),
      _ => FailureServer(message: message, isBackendMessage: isBackend),
    };
  }

  bool _isKnownCode(int code) => const {400, 401, 402, 403, 404, 409, 413, 500, 502, 503}.contains(code);

  String _concatCodeError(String message, int code) {
    if (message.isEmpty) return '[$code]';
    return '$message [$code]';
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yala/data/network/remote/dio/token_interceptor.dart';

class DioClient {
  static const int _connectTimeoutS = 20; // holgado para redes lentas
  static const int _receiveTimeoutS = 50; // I/O amplio (read en OkHttp)
  static const int _sendTimeoutS = 50; // I/O amplio (write en OkHttp)
  static const int _chunkSize = 800;

  Dio getDio({
    required String baseUrl,
    required TokenInterceptor tokenInterceptor,
  }) {
    final dio = Dio(_buildBaseOptions(baseUrl));
    _addInterceptors(
      dio: dio,
      tokenInterceptor: tokenInterceptor,
    );
    return dio;
  }

  BaseOptions _buildBaseOptions(
    String baseUrl,
  ) {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: _connectTimeoutS),
      receiveTimeout: const Duration(seconds: _receiveTimeoutS),
      sendTimeout: const Duration(seconds: _sendTimeoutS),
    );
  }

  void _addInterceptors({
    required Dio dio,
    required TokenInterceptor tokenInterceptor,
  }) {
    dio.interceptors.addAll([
      if (kDebugMode) _buildLogInterceptor(),
      tokenInterceptor,
    ]);
  }

  LogInterceptor _buildLogInterceptor() {
    return LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (o) => _printLongString(o.toString()),
    );
  }

  void _printLongString(String text) {
    RegExp('.{1,$_chunkSize}')
        .allMatches(text)
        .forEach(
          (m) => debugPrint(
            m.group(0),
          ),
        );
  }
}

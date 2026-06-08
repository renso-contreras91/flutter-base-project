class BaseResponse<T> {
  final int? status;
  final String? message;
  final T? data;

  const BaseResponse({
    this.status,
    this.message,
    this.data,
  });

  bool get isProcessedSuccessfully => status != null && status! >= 200 && status! <= 299;

  factory BaseResponse.fromJson({
    required Map<String, dynamic> json,
    required T? Function(Map<String, dynamic>? json) fromJsonT,
    int? httpStatusFallback,
  }) {
    return BaseResponse(
      status: (json['statusCode'] ?? json['status'] ?? httpStatusFallback) as int?,
      message: json['message'] as String?,
      data: fromJsonT(json['data']),
    );
  }
}

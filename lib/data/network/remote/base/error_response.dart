class ErrorResponse {
  final String? message;
  final String? error;

  const ErrorResponse({
    this.message,
    this.error,
  });

  factory ErrorResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ErrorResponse(
      message: json['message'] as String?,
      error: json['error'] as String?,
    );
  }
}

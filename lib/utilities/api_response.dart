class ApiResponse<T> {
  final T? data;
  final String? message;
  final bool hasError;

  ApiResponse({
    this.data,
    this.message,
    this.hasError = false,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(data: data, hasError: false);
  }

  factory ApiResponse.error(String message) {
    return ApiResponse(message: message, hasError: true);
  }

  bool get hasData => data != null;
}

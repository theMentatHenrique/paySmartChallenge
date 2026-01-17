class BaseAPIResponse<T> {
  final bool success;
  final String? message;
  final int? statusCode;
  final int? page;
  final List<T>? results;

  BaseAPIResponse({
    required this.success,
    this.message,
    this.statusCode,
    this.page,
    this.results,
  });
}
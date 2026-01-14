class BaseNetworkResponse<T> {
  final bool success;
  final String? message;
  final int? statusCode;
  final int? page;
  final List<T>? results;

  BaseNetworkResponse({
    required this.success,
    this.message,
    this.statusCode,
    this.page,
    this.results,
  });

  factory BaseNetworkResponse.success(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonModel
      ) {
    return BaseNetworkResponse<T>(
      success: true,
      page: json['page'],
      results: (json['results'] as List)
          .map((item) => fromJsonModel(item))
          .toList(),
    );
  }

  factory BaseNetworkResponse.error(Map<String, dynamic> json, int httpCode) {
    return BaseNetworkResponse<T>(
      success: false,
      statusCode: json['status_code'] ?? httpCode,
      message: json['status_message'] ?? 'Erro desconhecido',
      results: null,
    );
  }

}
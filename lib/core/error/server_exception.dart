class ServerException implements Exception {
  final Map<String, dynamic> data;
  final int statusCode;
  final String message;

  ServerException({
    required this.data,
    required this.statusCode,
    required this.message,
  });
}

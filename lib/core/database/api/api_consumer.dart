abstract class ApiConsumer {
  Future get({required String path, Map<String, dynamic>? queryParameters});

  Future post({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Object body,
    Map<String, dynamic>? headers,
  });

  Future put({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> body,
  });

  Future delete({required String path, Map<String, dynamic>? queryParameters});
}

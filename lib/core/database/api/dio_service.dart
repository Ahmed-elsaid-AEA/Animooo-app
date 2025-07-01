import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/database/api/api_consumer.dart';
import 'package:animooo/core/error/server_exception.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:dio/dio.dart';

class DioService extends ApiConsumer {
  Dio dio;

  DioService(this.dio) {
    dio.options.baseUrl = ApiConstants.baseUrl;
    //TODO.. add connection time out duration
    //TODO.. add receiveTimeout: receiveTimeout
    //TODO.. add sendTimeout: sendTimeout
  }

  @override
  Future delete({required String path, Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get({required String path, Map<String, dynamic>? queryParameters}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future post({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Object body,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        //?success
        return response.data;
      } else {
        //?failure
        throw ServerException(
          data: response.data as Map<String, dynamic>,
          statusCode: response.statusCode!,
          message: '',
        );
      }
    } catch (e) {
      //?exception
      await handleDioException(e);
    }
  }

  Future<void> handleDioException(Object e) async {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: ConstsValuesManager.connectionTimeout,
          );
        case DioExceptionType.sendTimeout:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: ConstsValuesManager.sendTimeOut,
          );
        case DioExceptionType.receiveTimeout:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: ConstsValuesManager.receiveTimeOut,
          );
        case DioExceptionType.badCertificate:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: ConstsValuesManager.badCertificate,
          );
        case DioExceptionType.badResponse:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: ConstsValuesManager.badResponse,
          );
        case DioExceptionType.cancel:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: ConstsValuesManager.cancel,
          );
        case DioExceptionType.connectionError:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: ConstsValuesManager.connectionError,
          );
        case DioExceptionType.unknown:
          throw ServerException(
            data: await e.response?.data,
            statusCode: e.response!.statusCode ?? 408,
            message: ConstsValuesManager.unKnownError,
          );
      }
    }
  }

  @override
  Future put({
    required String path,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> body,
  }) {
    // TODO: implement put
    throw UnimplementedError();
  }
}

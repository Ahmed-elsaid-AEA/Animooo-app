import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/database/api/api_consumer.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/error/server_exception.dart';
import 'package:animooo/core/functions/app_navigations.dart';
import 'package:animooo/core/functions/app_scaffold_massanger.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/routes_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../hive/hive_helper.dart';

class DioService extends ApiConsumer {
  final Dio _dio;

  DioService(this._dio) {
    _initDio();
  }

  void _initDio() async {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = Duration(seconds: 10);
    _dio.options.receiveTimeout = Duration(seconds: 5);
    _dio.options.sendTimeout = Duration(seconds: 10);

    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
        onResponse: _onResponse,
      ),
    ]);
  }

  _onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    HiveHelper<String> hiveHelper = HiveHelper(
      ConstsValuesManager.tokenBoxName,
    );
    String token =
        (await hiveHelper.getValue(key: ConstsValuesManager.accessToken)) ?? "";

    options.headers[ApiConstants.authorization] = "Bearer $token";
    return handler.next(options);
  }

  _onError(DioException e, ErrorInterceptorHandler handler) async {
     if (e.response?.statusCode == 401 || e.response?.statusCode == 400) {
      if (e.response!.data.toString().toLowerCase().contains("token")) {
        String? accessToken = await _generateNewAccessToken();
        if (accessToken != null) {
          //update token
          return await _updateAccessToken(accessToken, e, handler);
        } else {
          await _logout();
        }
      }
    }
     return handler.next(e);
  }

  _updateAccessToken(
    String accessToken,
    DioException e,
    ErrorInterceptorHandler handler,
  ) async {
    HiveHelper hiveHelper = HiveHelper(ConstsValuesManager.tokenBoxName);
    await hiveHelper.addValue(
      key: ConstsValuesManager.accessToken,
      value: accessToken,
    );

    e.requestOptions.headers[ApiConstants.authorization] =
        "Bearer $accessToken";
    e.requestOptions.headers["retry"] = true;
    if (e.requestOptions.data is FormData) {
      _createNewFormData(e);
    }
    Response res = await _dio.fetch(e.requestOptions);
    return handler.resolve(res);
  }

  void _createNewFormData(DioException e) {
    FormData oldFormData = e.requestOptions.data as FormData;
    final newFormData = FormData();
    for (var field in oldFormData.fields) {
      newFormData.fields.add(MapEntry(field.key, field.value));
    }
    for (var file in oldFormData.files) {
      newFormData.files.add(MapEntry(file.key, file.value.clone()));
    }
    e.requestOptions.data = newFormData;
  }

  Future<void> _logout() async {
    HiveHelper hiveHelper = HiveHelper(ConstsValuesManager.tokenBoxName);
    await hiveHelper.deleteValue(key: ConstsValuesManager.accessToken);
    await hiveHelper.deleteValue(key: ConstsValuesManager.refreshToken);
    HiveHelper hiveHelper2 = HiveHelper(ConstsValuesManager.rememberMeBoxName);
    await hiveHelper2.deleteValue(key: ConstsValuesManager.rememberMe);

    GlobalKey<NavigatorState> navigationKey = getIt<GlobalKey<NavigatorState>>(
      instanceName: ConstsValuesManager.appNavigationState,
    );

    if (navigationKey.currentState != null) {
      var context = navigationKey.currentState!.context;

      if (context.mounted) {
        showAppSnackBar(
          context,
          ConstsValuesManager.sectionHasExpiredLoginAgain,
        );

        AppNavigation.pushNamedAndRemoveUntil(context, RoutesName.loginPage);
      }
    }
  }

  Future<String?> _generateNewAccessToken() async {
    try {
      Dio dio = Dio();
      dio.options.baseUrl = ApiConstants.baseUrl;
      dio.options.connectTimeout = Duration(seconds: 10);
      dio.options.receiveTimeout = Duration(seconds: 5);
      dio.options.sendTimeout = Duration(seconds: 10);
      HiveHelper<String> hiveHelper = HiveHelper(
        ConstsValuesManager.tokenBoxName,
      );
      String refreshToken =
          (await hiveHelper.getValue(key: ConstsValuesManager.refreshToken)) ??
          "";
      var response = await dio.post(
        ApiConstants.refreshTokenEndPoint,
        options: Options(headers: {ApiConstants.refreshToken: refreshToken}),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        //?success
        return response.data["access_token"];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future delete({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    // TODO: implement get
    try {
      Response response = await _dio.delete(
        path,
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

  @override
  Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    // TODO: implement get
    try {
      Response response = await _dio.get(
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

  @override
  Future post({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required Object body,
  }) async {
    try {
      Response response = await _dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
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

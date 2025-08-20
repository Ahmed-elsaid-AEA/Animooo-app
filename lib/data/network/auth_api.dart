import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/error/server_exception.dart';
import 'package:animooo/models/auth/auth_response.dart';
import 'package:animooo/models/auth/login_response.dart';
import 'package:animooo/models/auth/user_model.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../models/auth/new_otp_code_response.dart';
import '../../models/auth/otp_code_response.dart';

class AuthApi {
  AuthApi._();

  //TODO? don't forget generate code model automatically
  static Future<Either<FailureModel, AuthResponse>> signUp(
    UserModel user,
  ) async {
    try {
      DioService dioService = getIt<DioService>();
      var response = await dioService.post(
        path: ApiConstants.signUpEndpoint,
        body: FormData.fromMap({
          ApiConstants.firstName: user.firstName,
          ApiConstants.lastName: user.lastName,
          ApiConstants.email: user.email,
          ApiConstants.password: user.password,
          ApiConstants.phone: user.phone,
          ApiConstants.image: await MultipartFile.fromFile(
            user.image.path,
            filename: user.image.path.split("/").last,
          ),
        }),
      );
      return Right(AuthResponse.fromJson(response));
    } on ServerException catch (e) {
      return left(handleServerExceptionError(e));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          ApiConstants.errors: [e.toString()],
          ApiConstants.statusCode: ApiConstants.s500,
        }),
      );
    }
  }

  static Future<Either<FailureModel, OtpCodeResponse>> checkOtpAvailability(
    String email,
    String code,
  ) async {
    try {
      DioService dioService = getIt<DioService>();
      var response = await dioService.post(
        path: ApiConstants.otpCheckEndpoint,
        body: {ApiConstants.email: email, ApiConstants.code: code},
      );
      return Right(OtpCodeResponse.fromJson(response));
    } on ServerException catch (e) {
      return left(handleServerExceptionError(e));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          ApiConstants.errors: [e.toString()],
          ApiConstants.statusCode: ApiConstants.s500,
        }),
      );
    }
  }

  static Future<Either<FailureModel, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      DioService dioService = getIt<DioService>();
       var response = await dioService.get(
        path: ApiConstants.loginEndpoint,
        queryParameters: {
          ApiConstants.email: email,
          ApiConstants.password: password,
        },
      );

      return Right(LoginResponse.fromJson(response));
    } on ServerException catch (e) {
      print(e.data);
      return left(handleServerExceptionError(e));
    } catch (e) {
      print(e.toString());

      return Left(
        FailureModel.fromJson({
          ApiConstants.errors: [e.toString()],
          ApiConstants.statusCode: ApiConstants.s500,
        }),
      );
    }
  }

  static Future<Either<FailureModel, NewOtpCodeResponse>> resendCOtpCode(
    String email,
  ) async {
    try {
      DioService dioService = getIt<DioService>();
      var response = await dioService.post(
        path: ApiConstants.resendNewOtpCodeEndpoint,
        body: {ApiConstants.email: email},
      );
      return Right(NewOtpCodeResponse.fromJson(response));
    } on ServerException catch (e) {
      return left(handleServerExceptionError(e));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          ApiConstants.errors: [e.toString()],
          ApiConstants.statusCode: ApiConstants.s500,
        }),
      );
    }
  }

  static FailureModel handleServerExceptionError<T>(ServerException e) {
    Map<String, dynamic> errors;
    if (e.data["error"] == null) {
      errors = {
        "error": [e.data["message"].toString()],
        "statusCode": 504,
      };
    } else {
      errors = e.data;
    }
    return FailureModel.fromJson(errors);
  }
}

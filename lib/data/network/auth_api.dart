import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/error/server_exception.dart';
import 'package:animooo/models/auth/auth_response.dart';
import 'package:animooo/models/auth/user_model.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

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
          // ApiConstants.firstName: user.firstName,
          // ApiConstants.lastName: user.lastName,
          // ApiConstants.email: user.email,
          // ApiConstants.password: user.password,
          // ApiConstants.phone: user.phone,
          // ApiConstants.image: await MultipartFile.fromFile(
          //   user.image.path,
          //   filename: user.image.path.split("/").last,
          // ),
        }),
      );
      return Right(AuthResponse.fromJson(response));
    } on ServerException catch (e) {
      return Left(FailureModel.fromJson(e.data));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          ApiConstants.errors: [e.toString()],
          ApiConstants.statusCode: ApiConstants.s500,
        }),
      );
    }
  }

  static Future<Either<FailureModel, AuthResponse>> login(
    UserModel user,
  ) async {
    try {
      DioService dioService =
          getIt<DioService>(); //TODO? don't forget to inject
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
      return Left(FailureModel.fromJson(e.data));
    } catch (e) {
      return Left(
        FailureModel.fromJson({
          ApiConstants.errors: [e.toString()],
          ApiConstants.statusCode: ApiConstants.s500,
        }),
      );
    }
  }
}

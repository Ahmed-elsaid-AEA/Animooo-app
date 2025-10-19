import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/error/server_exception.dart';
import 'package:animooo/models/auth/auth_response.dart';
import 'package:animooo/models/auth/create_new_password_response.dart';
import 'package:animooo/models/auth/login_response.dart';
import 'package:animooo/models/auth/user_model.dart';
import 'package:animooo/models/category_model.dart';
import 'package:animooo/models/category_response.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../core/database/hive/hive_helper.dart';
import '../../core/resources/conts_values.dart';
import '../../models/auth/new_otp_code_response.dart';
import '../../models/auth/otp_code_response.dart';
import 'auth_api.dart';

class CategoryApi {
  CategoryApi._();

  static Future<Either<FailureModel, CategoryResponse>> createNewCategory(
    CategoryModel category,
  ) async {
    try {
      DioService dioService = getIt<DioService>();
      HiveHelper<String> hiveHelper = HiveHelper(
        ConstsValuesManager.tokenBoxName,
      );
      //TODO :: Change that way to put token
      String token =
          (await hiveHelper.getValue(key: ConstsValuesManager.accessToken)) ??
          "";
       var response = await dioService.post(
        headers: {ApiConstants.authorization: "Bearer $token"},
        path: ApiConstants.createNewCategoryEndpoint,
        body: FormData.fromMap({
          ApiConstants.name: category.name,
          ApiConstants.description: category.description,
          ApiConstants.image: await MultipartFile.fromFile(
            category.image.path,
            filename: category.image.path.split("/").last,
          ),
        }),
      );
       return Right(CategoryResponse.fromJson(response));
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
}

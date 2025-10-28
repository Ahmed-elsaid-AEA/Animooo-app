import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/error/server_exception.dart';
import 'package:animooo/models/auth/auth_response.dart';
import 'package:animooo/models/auth/create_new_password_response.dart';
import 'package:animooo/models/auth/login_response.dart';
import 'package:animooo/models/auth/user_model.dart';
import 'package:animooo/models/gategory/categories_model_response.dart';
import 'package:animooo/models/gategory/category_model.dart';
import 'package:animooo/models/gategory/category_response.dart';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../core/database/hive/hive_helper.dart';
import '../../core/resources/conts_values.dart';
import '../../models/animal/animal_model.dart';
import '../../models/auth/new_otp_code_response.dart';
import '../../models/auth/otp_code_response.dart';
import 'auth_api.dart';

class AnimalApi {
  AnimalApi._();

  static Future<Either<FailureModel, CategoryResponse>> createNewAnimal(
    AnimalModel animal,
  ) async {
    try {
      DioService dioService = getIt<DioService>();

      var response = await dioService.post(
        path: ApiConstants.addNewAnimalEndpoint,
        body: FormData.fromMap({
          ApiConstants.name: animal.name,
          ApiConstants.price: animal.description,
          ApiConstants.categoryId: animal.description,
          ApiConstants.description: animal.description,
          ApiConstants.image: await MultipartFile.fromFile(
            animal.image.path,
            filename: animal.image.path.split("/").last,
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

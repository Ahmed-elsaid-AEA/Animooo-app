import 'dart:io';

import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/error/server_exception.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:dio/dio.dart';

class AuthApi {
  AuthApi._();

  static Future signUp(File image) async {
    try {
      DioService dioService = DioService(Dio()); //TODO? don't forget to inject
      print(image);
      var response = await dioService.post(
        path: ApiConstants.signUpEndpoint,
        body: FormData.fromMap({
          ApiConstants.firstName: 'ahmed',
          ApiConstants.lastName: 'ahmed',
          ApiConstants.email: 'ahmed122727727@gmail.com',
          ApiConstants.password: '12345678A!@aw2',
          ApiConstants.phone: '01001398831',
          ApiConstants.image:await MultipartFile.fromFile(
            image.path,
            filename: image.path.split("/").last,
          ),
          // TODO add body
        }),
      );
      // TODO: handle response good
      print(response);
    } on ServerException catch (e) {
      // TODO: handle response bad
      print(e.message);
      print(e.statusCode);
      print(e.data);
    } catch (e) {
      // TODO: handle exception
      print(e.toString());
      print("normal exception");
    }
  }
}

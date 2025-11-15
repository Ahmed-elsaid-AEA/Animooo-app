import 'package:envied/envied.dart';

part 'api_constants.g.dart';

@Envied(path: ".env")
abstract class ApiConstants {
  ApiConstants._();

  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _ApiConstants.baseUrl;

  @EnviedField(varName: 'SIGN_UP_ENDPOINT')
  static const String signUpEndpoint = _ApiConstants.signUpEndpoint;

  @EnviedField(varName: 'LOGIN_ENDPOINT')
  static const String loginEndpoint = _ApiConstants.loginEndpoint;

  @EnviedField(varName: 'OTP_CHECK_ENDPOINT')
  static const String otpCheckEndpoint = _ApiConstants.otpCheckEndpoint;

  @EnviedField(varName: 'CREATE_NEW_PASSWORD_ENDPOINT')
  static const String createNewPasswordEndpoint =
      _ApiConstants.createNewPasswordEndpoint;

  @EnviedField(varName: 'RESEND_NEW_OTP_CODE_ENDPOINT')
  static const String resendNewOtpCodeEndpoint =
      _ApiConstants.resendNewOtpCodeEndpoint;
  @EnviedField(varName: 'CREATE_NEW_CATEGORY_ENDPOINT')
  static const String createNewCategoryEndpoint =
      _ApiConstants.createNewCategoryEndpoint;

  @EnviedField(varName: 'ADD_NEW_ANIMAL_ENDPOINT')
  static const String addNewAnimalEndpoint = _ApiConstants.addNewAnimalEndpoint;

  @EnviedField(varName: 'UPDATE_CATEGORY_ENDPOINT')
  static const String updateCategoryEndpoint =
      _ApiConstants.updateCategoryEndpoint;
  static const String firstName = 'firstName';
  static const String name = 'name';
  static const String description = 'description';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String image = 'image';

  static const String errors = 'error';

  static const int s500 = 500;

  static const String statusCode = 'statusCode';

  static const String code = 'code';

  static const String confirmPassword = 'confirmPassword';

  static const String authorization = "Authorization";

  @EnviedField(varName: 'REFRESH_TOKEN_ENDPOINT')
  static const String refreshTokenEndPoint = _ApiConstants.refreshTokenEndPoint;

  static const String refreshToken = "refresh_token";

  @EnviedField(varName: 'ALL_CATEGORIES_ENDPOINT')
  static const String getAllCategoriesEndpoint =
      _ApiConstants.getAllCategoriesEndpoint;

  static const String id = "id";

  static const String delete = "Delete";

  static const String areYouSureYouWantToDeleteThisCategory =
      "Are you sure you want to delete this category?";

  @EnviedField(varName: 'DELETE_CATEGORY_ENDPOINT')
  static const String deleteCategoryEndpoint =
      _ApiConstants.deleteCategoryEndpoint;

  static const String categoryId = "category_id";

  static const String price = "price";

  @EnviedField(varName: 'GET_ALL_ANIMAL_ENDPOINT')
  static const String getAllAnimalEndpoint = _ApiConstants.getAllAnimalEndpoint;

  @EnviedField(varName: 'DELETE_ANIMAL_ENDPOINT')
  static const String deleteAnimalEndpoint = _ApiConstants.deleteAnimalEndpoint;

  @EnviedField(varName: 'UPDATE_ANIMAL_ENDPOINT')
  static const String updateAnimalEndpoint = _ApiConstants.updateAnimalEndpoint;
  static const String animalPrice = "animal_price";
  static const String animalImage = "animal_image";
}

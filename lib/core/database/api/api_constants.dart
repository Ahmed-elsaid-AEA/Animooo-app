class ApiConstants {
  //TODO :://don't forget secure api constants
  ApiConstants._();

  static const String baseUrl = 'http://192.168.1.100:8000';
  static const String signUpEndpoint = '/api/signup';
  static const String otpCheckEndpoint = '/api/verfication_code';
  static const String loginEndpoint = '/api/login';
  static const String createNewPasswordEndpoint = '/api/create_new_possword';
  static const String resendNewOtpCodeEndpoint = '/api/create_new_verfication_code';
  static const String createNewCategoryEndpoint = '/api/createNewCategory';
  static const String addNewAnimalEndpoint = '/api/addNewAnimal';
  static const String updateCategoryEndpoint = '/api/updateCategory';
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

  static const String refreshTokenEndPoint = "/api/generateAccessToken";

  static const String refreshToken = "refresh_token";

  static const String  getAllCategoriesEndpoint = "/api/allCategories";

  static const String id = "id";

  static const String delete = "Delete";

  static const String areYouSureYouWantToDeleteThisCategory = "Are you sure you want to delete this category?";

  static const String deleteCategoryEndpoint = "/api/deleteCategory";

  static const String categoryId = "category_id";

  static const String price = "price";

  static const String getAllAnimalEndpoint = "/api/allAnimal";

  static const String deleteAnimalEndpoint = "/api/deleteAnimal";
}

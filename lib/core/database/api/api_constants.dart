class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://192.168.1.100:8000';
  static const String signUpEndpoint = '/api/signup';
  static const String otpCheckEndpoint = '/api/verfication_code';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String image = 'image';

  static const String errors = 'error';

  static const int s500 = 500;

  static const String statusCode = 'statusCode';

  static const String code = 'code';
}

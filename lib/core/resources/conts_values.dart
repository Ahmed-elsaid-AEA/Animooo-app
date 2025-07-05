import 'package:animooo/models/password_rules_model.dart';

class ConstsValuesManager {
  ConstsValuesManager._();

  static const String animooo = 'Animooo';
  static const String login = 'Log in';
  static const String firstName = 'First name';
  static const String lastName = 'Last name';

  static const String enterYourFirstName = 'Enter your first name';
  static const String enterYourLastName = 'Enter your last name';

  static const String
  pleaseEnterTheEmailAddressAssociatedWithYourAccountAndWeWillSendYouOtpToResetYourPassword =
      'Please enter the email address associated with your account, and we\'ll send you OTP to reset your password.';

  static const String phone = 'Phone';

  static const String enterYourPhone = 'Enter your phone';

  static const String confirmPassword = 'Confirm password';

  static const String email = 'Email';
  static const String forgetYourPassword = 'Forget Your Password ?';
  static const String otpVerification = 'OTP Verification';
  static const String pleaseEnterThe4DigitCodeSentYourPhoneNumber =
      'Please enter the 4 digit code sent your phone number';
  static const String password = 'Password';
  static const String confirm = 'Confirm';

  static const String resendCodeIn = 'Resend Code In';

  static const String enterYourEmailAddress = 'Enter your email address';
  static const String enterYourPassword = 'Enter your password';

  static const String forgotPassword = 'Forget Password....?';
  static const String dontHaveAnAccount = 'Don\'t have an account?';

  static const String signUpNow = 'Sign up now';
  static const String haveAnAccountAlready = 'Have an account already?';
  static const String signUp = 'Sign up';
  static const String passwordAddAllNecessaryCharactersToCreateSafePassword =
      'Please add all necessary characters to create safe password.';

  static const String thisFieldIsRequired = 'This field is required';

  static const String uploadImageForYourProfile =
      'Upload Image For Your Profile';

  static const String selectFile = 'Select File';
  static const String selectYourImage = 'Select Your Image';

  static const String back = 'Back';

  static const String sendCode = 'Send Code';

  static const String enterYourConfirmPassword = 'Enter your confirm password';

  static const String cancel = 'Cancel';

  static const String createNewPassword = 'Create New Password';

  static const String newPassword = 'New Password';

  static const String submit = 'Submit';

  static const String firstNameMustBeAtLeastThreeLetters =
      'First name must be at least three letters';

  static const String secondNameMustBeAtLeastThreeLetters =
      'Second name must be at least three letters';

  static const String enterValidEmail = 'Enter valid email';

  static const String
  passwordMustBeAtLeastEightCharactersAndContainAtLeastOneUpperCaseLetterOneLowerCaseLetterAndOneNumber =
      'Password must be at least eight characters and contain at least one upper case letter, one lower case letter, and one number';

  static const String title = 'title';
  static const String valid = 'valid';

  static const String passwordAndConfirmPasswordMustBeTheSame =
      'Password and confirm password must be the same';

  static const String camera = 'Camera';

  static const String gallery = 'Gallery';

  static const String somethingWentWrong = 'Something went wrong';

  static const String connectionTimeout = 'Connection Timeout';

  static const String noInternetConnection = 'No Internet Connection';

  static const String sendTimeOut = 'Send Time Out';

  static const String receiveTimeOut = 'Receive Time Out';

  static const String badCertificate = 'Bad Certificate';

  static const String badResponse = 'Bad Response';

  static const String requestWasCancelled = 'Request was cancelled';

  static const String connectionError = 'Connection Error';

  static const String unKnownError = 'Unknown Error';

  static const String image = 'image';

  static const String enterValidPhoneNumber = 'Enter valid phone number';
}

class ConstsListsManager {
  static List<PasswordRulesModel> passwordRulesRequirements = [
    PasswordRulesModel(title: 'Minimum characters 12', valid: false),
    PasswordRulesModel(title: 'One uppercase character', valid: false),
    PasswordRulesModel(title: 'One lowercase character', valid: false),
    PasswordRulesModel(title: 'One special character', valid: false),
    PasswordRulesModel(title: 'One number', valid: false),
  ];
}

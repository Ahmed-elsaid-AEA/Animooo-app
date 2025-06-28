import '../resources/conts_values.dart';

class AppValidators {
  static String? firstNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ConstsValuesManager.thisFieldIsRequired;
    } else if (value.length < 3) {
      return ConstsValuesManager.firstNameMustBeAtLeastThreeLetters;
    } else {
      return null;
    }
  }

  static String? lastNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ConstsValuesManager.thisFieldIsRequired;
    } else if (value.length < 3) {
      return ConstsValuesManager.secondNameMustBeAtLeastThreeLetters;
    } else {
      return null;
    }
  }

  static emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ConstsValuesManager.thisFieldIsRequired;
    } else if (isEmail(value) == false) {
      return ConstsValuesManager.enterValidEmail;
    } else {
      return null;
    }
  }

  static bool isEmail(String value) {
    final emailRegEx = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegEx.hasMatch(value);
  }

  static passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return ConstsValuesManager.enterYourPassword;
    } else if (isPassword(value) == false) {
      return ConstsValuesManager
          .passwordMustBeAtLeastEightCharactersAndContainAtLeastOneUpperCaseLetterOneLowerCaseLetterAndOneNumber;
    } else {
      return null;
    }
  }

  static confirmPasswordValidator(
    String? valuePassword,
    String? valueConfirmPassword,
  ) {
    if (valuePassword == null || valuePassword.trim().isEmpty) {
      return ConstsValuesManager.enterYourPassword;
    } else if (valuePassword != valueConfirmPassword) {
      return ConstsValuesManager
          .passwordAndConfirmPasswordMustBeTheSame;
    } else {
      return null;
    }
  }

  static bool isPassword(String value) {
    final passwordRegEx = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );

    return passwordRegEx.hasMatch(value);
  }
}

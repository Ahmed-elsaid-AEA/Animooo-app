import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/custom_text_form_field.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:animooo/view/signup/widgets/password_field_sign_up_page.dart';
import 'package:animooo/view/signup/widgets/phone_field_sign_up_page.dart';
import 'package:animooo/view/signup/widgets/required_rules_for_password_sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart' show ColorManager;
import '../../../core/resources/conts_values.dart' show ConstsValuesManager;
import 'confirm_password_field_sign_up_page.dart';
import 'email_field_sign_up_page.dart';
import 'first_name_field_sign_up_page.dart';
import 'last_name_field_sign_up_page.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.onPressedAtEye,
    required this.visible,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback? onPressedAtEye;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FirstNameFieldSignUpPage(),
          LastNameFieldSignUpPage(),
          EmailFieldSignUpPage(),
          PhoneFieldSignUpPage(),
          PasswordFieldSignUpPage(visiblePassword: true, onPressedAtEye: () {}),
          RequiredRulesForPasswordSignUpPage(),
          ConfirmPasswordFieldSignUpPage(
            visibleConfirmPassword: true,
            onPressedAtEye: () {},
          ),
        ],
      ),
    );
  }
}

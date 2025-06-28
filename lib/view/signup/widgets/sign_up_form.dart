import 'package:animooo/core/functions/app_validators.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/custom_required_field.dart';
import 'package:animooo/core/widgets/custom_required_password_field.dart';
import 'package:animooo/core/widgets/custom_text_form_field.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:animooo/view/signup/widgets/required_rules_for_password_sign_up_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/widgets/custom_select_your_image_widget.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.onPressedAtEyePassword,
    required this.visiblePassword,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.onPressedAtEyeConfirmPassword,
    required this.visibleConfirmPassword,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback? onPressedAtEyePassword;
  final bool visiblePassword;
  final bool visibleConfirmPassword;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback? onPressedAtEyeConfirmPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRequiredField(
            validator: (value) {
              return AppValidators.firstNameValidator(value);
            },
            controller: firstNameController,
            title: ConstsValuesManager.firstName,
            hintText: ConstsValuesManager.enterYourFirstName,
          ),
          VerticalSpace(HeightsManager.h16),
          CustomRequiredField(
            validator: (value) {
              return AppValidators.lastNameValidator(value);
            },
            controller: lastNameController,
            title: ConstsValuesManager.lastName,
            hintText: ConstsValuesManager.enterYourLastName,
          ),
          CustomRequiredField(
            controller: emailController,
            title: ConstsValuesManager.email,
            hintText: ConstsValuesManager.enterYourEmailAddress,
            validator: (value) {
              return AppValidators.emailValidator(value);
            },
          ),
          VerticalSpace(HeightsManager.h16),

          CustomRequiredPasswordField(
            controller: passwordController,
            onPressedAtEye: onPressedAtEyePassword,
            title: ConstsValuesManager.password,
            hintText: ConstsValuesManager.enterYourPassword,
            visible: visiblePassword,
          ),

          VerticalSpace(HeightsManager.h8),

          RequiredRulesForPasswordSignUpPage(),
          CustomRequiredPasswordField(
            onPressedAtEye: onPressedAtEyeConfirmPassword,
            title: ConstsValuesManager.confirmPassword,
            visible: visibleConfirmPassword,
            controller: confirmPasswordController,
            hintText: ConstsValuesManager.enterYourConfirmPassword,
          ),
          VerticalSpace(HeightsManager.h16),

          Text(
            ConstsValuesManager.uploadImageForYourProfile,
            style: TextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorManager.kGreyColor,
              fontFamily: FontsManager.poppinsFontFamily,
              fontWeight: FontWeight.w400,
            ),
          ),
          VerticalSpace(HeightsManager.h8),
          CustomSelectImageWidget(),
          VerticalSpace(HeightsManager.h28),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';

import 'package:animooo/core/enums/select_image_status.dart';
import 'package:animooo/core/functions/app_validators.dart';
import 'package:animooo/core/resources/extenstions.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/custom_required_confirm_password_field.dart';
import 'package:animooo/core/widgets/custom_required_field.dart';
import 'package:animooo/core/widgets/custom_required_password_field.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:animooo/models/password_rules_model.dart';
import 'package:animooo/view/signup/widgets/required_rules_for_password_sign_up_page.dart';
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
    required this.visiblePasswordOutPutStream,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.onPressedAtEyeConfirmPassword,
    required this.visibleConfirmPasswordOutPutStream,
    required this.onChangedPassword,
    required this.fileImageOutPutData,
    required this.onTapAtSelectImage,
    required this.selectImageStatus,
    required this.phoneController,
    required this.onChanged,
    required this.listPasswordRulesOutPutStream,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback? onPressedAtEyePassword;
  final Stream<File?> fileImageOutPutData;
  final Stream<bool> visiblePasswordOutPutStream;
  final Stream<bool> visibleConfirmPasswordOutPutStream;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback? onPressedAtEyeConfirmPassword;
  final ValueChanged<String> onChangedPassword;
  final void Function(FormFieldState<File>) onTapAtSelectImage;
  final SelectImageStatus selectImageStatus;
  final Stream<List<PasswordRulesModel>> listPasswordRulesOutPutStream;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRequiredField(
            keyboardType: TextInputType.name,
            onChanged: onChanged,
            validator: (value) {
              return AppValidators.firstNameValidator(value);
            },
            controller: firstNameController,
            title: ConstsValuesManager.firstName,
            hintText: ConstsValuesManager.enterYourFirstName,
          ),
          VerticalSpace(HeightsManager.h16),
          CustomRequiredField(
            keyboardType: TextInputType.name,
            onChanged: onChanged,
            validator: (value) {
              return AppValidators.lastNameValidator(value);
            },
            controller: lastNameController,
            title: ConstsValuesManager.lastName,
            hintText: ConstsValuesManager.enterYourLastName,
          ),
          VerticalSpace(HeightsManager.h16),
          CustomRequiredField(
            keyboardType: TextInputType.emailAddress,
            onChanged: onChanged,
            controller: emailController,
            title: ConstsValuesManager.email,
            hintText: ConstsValuesManager.enterYourEmailAddress,
            validator: (value) {
              return AppValidators.emailValidator(value);
            },
          ),
          VerticalSpace(HeightsManager.h16),
          CustomRequiredField(
            onChanged: onChanged,
            keyboardType: TextInputType.phone,
            controller: phoneController,
            title: ConstsValuesManager.phone,
            hintText: ConstsValuesManager.enterYourPhone,
            validator: (value) {
              return AppValidators.phoneValidator(value);
            },
          ),
          VerticalSpace(HeightsManager.h16),
          StreamBuilder<bool>(
            stream: visiblePasswordOutPutStream,
            initialData: false,
            builder: (context, snapshot) => CustomRequiredPasswordField(
              usedValidate: false,
              onChanged: (value) {
                onChangedPassword(value);
                onChanged(value);
              },
              controller: passwordController,
              onPressedAtEye: onPressedAtEyePassword,
              title: ConstsValuesManager.password,
              hintText: ConstsValuesManager.enterYourPassword,
              visible: snapshot.data ?? false,
            ),
          ),

          VerticalSpace(HeightsManager.h8),

          RequiredRulesForPasswordSignUpPage(
            listPasswordRulesOutputStream: listPasswordRulesOutPutStream,
          ),

          StreamBuilder<bool>(
            initialData: false,
            stream: visibleConfirmPasswordOutPutStream,
            builder: (context, snapshot) => CustomRequiredConfirmPasswordField(
              onChanged: onChanged,
              onPressedAtEye: onPressedAtEyeConfirmPassword,
              visible: snapshot.data ?? false,
              controller: confirmPasswordController,
              password: passwordController.getText,
            ),
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
          StreamBuilder<File?>(
            stream: fileImageOutPutData,
            initialData: null,
            builder: (context, snapshot) => CustomSelectImageWidget(
              file: snapshot.data,
              onTapAtSelectImage: onTapAtSelectImage,
              selectImageStatus: selectImageStatus,
            ),
          ),
          VerticalSpace(HeightsManager.h28),
        ],
      ),
    );
  }
}

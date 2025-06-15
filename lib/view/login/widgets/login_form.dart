import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/custom_text_form_field.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart' show ColorManager;
import '../../../core/resources/conts_values.dart' show ConstsValuesManager;

class LoginForm extends StatelessWidget {
  const LoginForm({
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ConstsValuesManager.email,
              style: TextStyle(
                fontSize: FontSizeManager.s16,
                color: ColorManager.kGreyColor,
                fontFamily: FontsManager.poppinsFontFamily,
              ),
            ),
          ),
          VerticalSpace(height: HeightsManager.h6),
          CustomTextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return ConstsValuesManager.enterYourEmailAddress;
              }
              //TODO:: add email validation
              else {
                return null;
              }
            },
            hintText: ConstsValuesManager.enterYourEmailAddress,
          ),
          VerticalSpace(height: HeightsManager.h16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ConstsValuesManager.password,
              style: TextStyle(
                fontSize: FontSizeManager.s16,
                color: ColorManager.kGreyColor,
                fontFamily: FontsManager.poppinsFontFamily,
              ),
            ),
          ),
          VerticalSpace(height: HeightsManager.h6),
          CustomTextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return ConstsValuesManager.enterYourPassword;
              }
              //TODO:: add password validation
              else {
                return null;
              }
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            suffixIcon: IconButton(
              onPressed: onPressedAtEye,
              icon: Icon(
                visible == true ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                color: ColorManager.kGrey2Color,
              ),
            ),
            hintText: ConstsValuesManager.enterYourPassword,
          ),
        ],
      ),
    );
  }
}

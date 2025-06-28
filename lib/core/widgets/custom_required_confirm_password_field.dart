import 'package:animooo/core/functions/app_validators.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/assets_values_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/conts_values.dart';
import '../resources/fonts_size_manager.dart';
import '../resources/heights_manager.dart';
import 'custom_text_form_field.dart';

class CustomRequiredConfirmPasswordField extends StatelessWidget {
  const CustomRequiredConfirmPasswordField({
    super.key,
    required this.onPressedAtEye,
    required this.visible,
    required this.controller,
    this.usedValidate = true,
    this.onChanged,
    required this.password,
  });

  final ValueChanged<String>? onChanged;

  final bool usedValidate;
  final VoidCallback? onPressedAtEye;
  final String password;
  final bool visible;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ConstsValuesManager.confirmPassword,
            style: TextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorManager.kGreyColor,
              fontFamily: FontsManager.poppinsFontFamily,
            ),
          ),
        ),
        VerticalSpace(HeightsManager.h6),
        CustomTextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: usedValidate == true
              ? (value) {
                  return AppValidators.confirmPasswordValidator(
                    value,
                    password,
                  );
                }
              : null,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          suffixIcon: IconButton(
            onPressed: onPressedAtEye,
            icon: Icon(
              visible == true ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
              color: ColorManager.kGrey2Color,
            ),
          ),
          hintText: ConstsValuesManager.enterYourConfirmPassword,
        ),
      ],
    );
  }
}

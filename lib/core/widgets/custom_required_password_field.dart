import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/assets_values_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/conts_values.dart';
import '../resources/fonts_size_manager.dart';
import '../resources/heights_manager.dart';
import 'custom_text_form_field.dart';

class CustomRequiredPasswordField extends StatelessWidget {
  const CustomRequiredPasswordField({
    super.key,
    required this.title,
    required this.onPressedAtEye,
    required this.visible,
    required this.controller,
    required this.hintText,
  });

  final String hintText;
  final String title;
  final VoidCallback? onPressedAtEye;
  final bool visible;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
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
          hintText: hintText,
        ),
      ],
    );
  }
}

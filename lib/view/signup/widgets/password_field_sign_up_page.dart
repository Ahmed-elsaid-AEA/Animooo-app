import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class PasswordFieldSignUpPage extends StatelessWidget {
  const PasswordFieldSignUpPage({super.key, required this.onPressedAtEye, required this.visiblePassword});

  final bool visiblePassword ;
  final void Function() onPressedAtEye;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        VerticalSpace( HeightsManager.h6),
        CustomTextFormField(
          controller: TextEditingController(),

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
          obscureText: !visiblePassword,
          suffixIcon: IconButton(
            onPressed: onPressedAtEye,
            icon: Icon(
              visiblePassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
              color: ColorManager.kGrey2Color,
            ),
          ),
          hintText: ConstsValuesManager.enterYourPassword,
        ),
        VerticalSpace( HeightsManager.h8),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class ConfirmPasswordFieldSignUpPage extends StatelessWidget {
  const ConfirmPasswordFieldSignUpPage({
    super.key,
    required this.visibleConfirmPassword,
    required this.onPressedAtEye,
  });

  final bool visibleConfirmPassword;

  final void Function() onPressedAtEye;

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
          obscureText: !visibleConfirmPassword,
          suffixIcon: IconButton(
            onPressed: onPressedAtEye,
            icon: Icon(
              visibleConfirmPassword
                  ? CupertinoIcons.eye
                  : CupertinoIcons.eye_slash,
              color: ColorManager.kGrey2Color,
            ),
          ),
          hintText: ConstsValuesManager.enterYourPassword,
        ),
        VerticalSpace(HeightsManager.h16)
      ],
    );
  }
}

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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/widgets/custom_select_your_image_widget.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRequiredField(
            controller: TextEditingController(),
            title: ConstsValuesManager.firstName,
            hintText: ConstsValuesManager.enterYourFirstName,
          ),
          VerticalSpace(HeightsManager.h16),
          CustomRequiredField(
            controller: TextEditingController(),
            title: ConstsValuesManager.lastName,
            hintText: ConstsValuesManager.enterYourLastName,
          ),

          VerticalSpace(HeightsManager.h16),

          CustomRequiredPasswordField(
            controller: TextEditingController(),
            onPressedAtEye: () {},
            title: ConstsValuesManager.password,
            hintText: ConstsValuesManager.enterYourPassword,
            visible: true,
          ),

          VerticalSpace(HeightsManager.h8),

          RequiredRulesForPasswordSignUpPage(),
          CustomRequiredPasswordField(
            onPressedAtEye: () {},
            title: ConstsValuesManager.confirmPassword,
            visible: true,
            controller: TextEditingController(),
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

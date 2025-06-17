import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/custom_required_field.dart';
import 'package:animooo/core/widgets/custom_required_password_field.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/conts_values.dart';

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
          CustomRequiredField(
            validator: (value) {
              //TODO:: add email validation
              if (value == null || value.trim().isEmpty) {
                return ConstsValuesManager.enterYourEmailAddress;
              } else {
                return null;
              }
            },
            controller: TextEditingController(),
            title: ConstsValuesManager.email,
            hintText: ConstsValuesManager.enterYourEmailAddress,
          ),
          VerticalSpace(HeightsManager.h16),

          CustomRequiredPasswordField(
            title: ConstsValuesManager.password,
            onPressedAtEye: onPressedAtEye,
            visible: visible,
            controller: TextEditingController(),
            hintText: ConstsValuesManager.enterYourPassword,
          ),
        ],
      ),
    );
  }
}

import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/custom_required_field.dart';
import 'package:animooo/core/widgets/custom_required_password_field.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/functions/app_validators.dart';
import '../../../core/resources/conts_values.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.onPressedAtEye,
    required this.eyeVisibleOutPutStream,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final VoidCallback? onPressedAtEye;
  final Stream<bool> eyeVisibleOutPutStream;
  final TextEditingController emailController;

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomRequiredField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              return AppValidators.emailValidator(value);
            },
            controller: emailController,
            title: ConstsValuesManager.email,
            hintText: ConstsValuesManager.enterYourEmailAddress,
          ),
          VerticalSpace(HeightsManager.h16),

          StreamBuilder<bool>(
            stream: eyeVisibleOutPutStream,
            initialData: false,
            builder: (context, snapshot) => CustomRequiredPasswordField(
              useDefaultErrorBuilder: true,
              usedValidate: true,
              title: ConstsValuesManager.password,
              onPressedAtEye: onPressedAtEye,
              visible: snapshot.data ?? false,
              controller: passwordController,
              hintText: ConstsValuesManager.enterYourPassword,
            ),
          ),
        ],
      ),
    );
  }
}

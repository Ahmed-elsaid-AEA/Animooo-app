import 'package:animooo/view/signup/widgets/sign_up_form.dart';
import 'package:animooo/view/signup/widgets/sign_up_title.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/conts_values.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/widgets/app_logo_and_title_widget.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../../login/widgets/bottom_nav_bar_login_page.dart';
import '../../login/widgets/title_login_page.dart';
import '../widgets/required_rules_for_password_sign_up_page.dart';
import '../widgets/sign_in_now.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: PaddingManager.pw18),
              child: Column(
                children: [
                  AppLogoAndTitleWidget(),
                  VerticalSpace(HeightsManager.h9_15),
                  TitleSignUpPage(),
                  SignUpForm(
                    formKey: GlobalKey(),
                    onPressedAtEye: () {},
                    visible: true,
                  ),

                  AppButton(text: ConstsValuesManager.signUp, onTap: () {}),
                  VerticalSpace(HeightsManager.h8),
                  SignInNow(onPressedSignInNow: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

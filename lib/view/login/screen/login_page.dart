import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/app_logo_and_title_widget.dart';
import 'package:animooo/core/widgets/buttons/app_button.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:animooo/view/login/widgets/forget_password_login.dart';
import 'package:animooo/view/login/widgets/login_form.dart';
 import 'package:flutter/material.dart';

import '../../../core/resources/padding_manager.dart' show PaddingManager;
import '../widgets/bottom_nav_bar_login_page.dart';
import '../widgets/title_login_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingManager.pw18),
            child: Column(
              children: [
                AppLogoAndTitleWidget(),
                VerticalSpace(height: HeightsManager.h9_15),
                TitleLoginPage(),

                LoginForm(
                  formKey: GlobalKey(),
                  onPressedAtEye: () {},
                  visible: true, //TODO:: add form key
                ),
                ForgetPasswordLogin(onPressedAtForgetPassword: () {}),
                VerticalSpace(height: HeightsManager.h31),
                AppButton(text: ConstsValuesManager.login, onTap: () {}),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarLoginPage(onPressedSignUpNow: () {}),
    );
  }
}

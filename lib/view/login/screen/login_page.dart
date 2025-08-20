import 'package:animooo/controller/login_screen_controller.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/routes_manager.dart';
import 'package:animooo/core/widgets/app_logo_and_title_widget.dart';
import 'package:animooo/core/widgets/buttons/app_button.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:animooo/view/login/widgets/forget_password_login.dart';
import 'package:animooo/view/login/widgets/login_form.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/padding_manager.dart';
import '../../../core/widgets/loading/app_model_progress_hud.dart';
import '../widgets/bottom_nav_bar_login_page.dart';
import '../widgets/title_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginScreenController _loginScreenController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginScreenController = LoginScreenController(context);
  }

  @override
  void dispose() {
    _loginScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppModelProgressHud(
        loadingOutputStream:
            _loginScreenController.loadingScreenStateOutPutStream,
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: PaddingManager.pw18),
                child: Column(
                  children: [
                    AppLogoAndTitleWidget(),
                    VerticalSpace(HeightsManager.h9_15),
                    TitleLoginPage(),

                    LoginForm(
                      onChanged: _loginScreenController.onChangeTextFiled,
                      formKey: _loginScreenController.loginFormKey,
                      onPressedAtEye: _loginScreenController.onPressedAtEye,
                      eyeVisibleOutPutStream:
                          _loginScreenController.eyeVisibleOutPutStream,
                      emailController: _loginScreenController.emailController,
                      passwordController:
                          _loginScreenController.passwordController,
                    ),
                    ForgetPasswordLogin(
                      onPressedAtForgetPassword:
                          _loginScreenController.onPressedAtForgetPassword,
                    ),

                    AppButton(
                      text: ConstsValuesManager.login,
                      buttonStatusOutputStream:
                          _loginScreenController.loginButtonStatusOutPutStream,
                      onTap: _loginScreenController.onPressedAtLoginButton,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBarLoginPage(
        onPressedSignUpNow: () {
          Navigator.pushNamed(context, RoutesName.signupPage);
        },
      ),
    );
  }
}

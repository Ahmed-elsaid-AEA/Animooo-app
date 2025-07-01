import 'package:animooo/controller/sign_up_controller.dart';
import 'package:animooo/core/services/internet_checker_service.dart';
import 'package:animooo/view/signup/widgets/sign_up_form.dart';
import 'package:animooo/view/signup/widgets/sign_up_title.dart';
import 'package:dio/dio.dart';
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpController signUpController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpController = SignUpController();
  }

  @override
  void dispose() {
    signUpController.dispose();
    super.dispose();
  }

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
                    fileImage: signUpController.fileImage,
                    formKey: signUpController.formKey,
                    confirmPasswordController:
                        signUpController.confirmPasswordController,
                    emailController: signUpController.emailController,
                    firstNameController: signUpController.firstNameController,
                    lastNameController: signUpController.lastNameController,
                    passwordController: signUpController.passwordController,
                    onPressedAtEyePassword: () {
                      signUpController.onPressedAtEyePassword();
                      setState(() {});
                    },
                    onPressedAtEyeConfirmPassword: () {
                      signUpController.onPressedAtEyeConfirmPassword();
                      setState(() {});
                    },
                    visibleConfirmPassword:
                        signUpController.visibleConfirmPassword,
                    visiblePassword: signUpController.visiblePassword,
                    onChangedPassword: (String value) {
                      signUpController.onChangePassword(value);
                      setState(() {});
                    },
                    onTapAtSelectImage: () async{
                      await signUpController.onTapAtSelectImage(context);
                      setState(() {});
                    },
                    selectImageStatus: signUpController.selectImageStatus,
                    phoneController: signUpController.phoneController,
                    onChanged: (String value) {
                      signUpController.checkValidate();
                      setState(() {});
                    },
                  ),

                  AppButton(
                    text: ConstsValuesManager.signUp,
                    onTap: signUpController.signUpActive == true
                        ? () async {
                            signUpController.onTapSignUp();
                            setState(() {});
                          }
                        : null,
                  ),
                  VerticalSpace(HeightsManager.h8),
                  SignInNow(
                    onPressedSignInNow: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class SignUpController {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  bool visibleConfirmPassword=false;
  bool visiblePassword=false;

  void initState() {
    //?init controllers
    initControllers();
    //?
  }

  void dispose() {
    disposeControllers();
  }
  void initControllers() async {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
   }

  SignUpController() {
    initState();
  }
}

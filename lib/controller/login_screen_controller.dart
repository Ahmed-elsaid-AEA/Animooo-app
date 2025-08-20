import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../core/enums/button_status_enum.dart';
import '../core/enums/screen_status_state.dart';
import '../core/resources/routes_manager.dart';

class LoginScreenController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  ButtonStatusEnum loginButtonStatus = ButtonStatusEnum.disabled;
  ScreensStatusState screenState = ScreensStatusState.initial;
  bool eyeVisible = false;

  //?textControllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

  //?streams

  //?eye stream
  late StreamController<bool> eyeStreamController;

  late Sink<bool> eyeInput;
  late Stream<bool> eyeVisibleOutPutStream;

  //? button status stream
  late Stream<ButtonStatusEnum> loginButtonStatusOutPutStream;
  late Sink<ButtonStatusEnum> loginButtonStatusInput;
  late StreamController<ButtonStatusEnum> loginButtonStatusController;

  //? screen state stream
  late Stream<bool> loadingScreenStateOutPutStream;
  late Sink<bool> loadingScreenStateInput;
  late StreamController<bool> loadingScreenStateController;

  LoginScreenController() {
    init();
  }

  void init() {
    //?init Controllers
    initControllers();
    //?init textControllers
    initTextControllers();
    //?change button status
    changeButtonStatus(ButtonStatusEnum.disabled);
  }
  void changeButtonStatus(ButtonStatusEnum status) {
    loginButtonStatusInput.add(status);
  }

  void initTextControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void initControllers() {
    //eye stream
    eyeStreamController = StreamController<bool>();
    eyeInput = eyeStreamController.sink;
    eyeVisibleOutPutStream = eyeStreamController.stream;
    //button status stream
    loginButtonStatusController = StreamController<ButtonStatusEnum>();
    loginButtonStatusInput = loginButtonStatusController.sink;
    loginButtonStatusOutPutStream = loginButtonStatusController.stream;
    //screen state stream
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateInput = loadingScreenStateController.sink;
    loadingScreenStateOutPutStream = loadingScreenStateController.stream;
  }

  void dispose() {
    //?dispose streams
    disposeStreams();
  }

  void disposeStreams() {
    eyeStreamController.close();
    eyeInput.close();
  }

  void onPressedAtEye() {
    eyeVisible = !eyeVisible;
    eyeInput.add(eyeVisible);
  }

  void onPressedAtForgetPassword(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.forgetPassword);
  }

  void onPressedAtLoginButton() {
    if (loginFormKey.currentState!.validate()) {
      //?request login
    }
  }
}

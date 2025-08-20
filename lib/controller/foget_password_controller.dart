import 'dart:async';

import 'package:flutter/material.dart';

import '../core/enums/button_status_enum.dart';
import '../core/resources/conts_values.dart';
import '../core/resources/routes_manager.dart';

class ForgetPasswordController {
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  ButtonStatusEnum loginButtonStatus = ButtonStatusEnum.disabled;

  //?textControllers
  late TextEditingController emailController;

  //? button status stream
  late Stream<ButtonStatusEnum> sendCodeButtonStatusOutPutStream;
  late Sink<ButtonStatusEnum> sendCodeButtonStatusInput;
  late StreamController<ButtonStatusEnum> sendCodeButtonStatusController;

  ForgetPasswordController() {
    init();
  }

  void init() {
    //?init Controllers
    initControllers();
    //?init textControllers
    initTextControllers();
    //?change button status
    changeSendCodeButtonStatus(ButtonStatusEnum.disabled);
  }

  void initControllers() {
    //send code button status stream
    sendCodeButtonStatusController = StreamController<ButtonStatusEnum>();
    sendCodeButtonStatusInput = sendCodeButtonStatusController.sink;
    sendCodeButtonStatusOutPutStream = sendCodeButtonStatusController.stream;
  }

  void initTextControllers() {
    //emailController
    emailController = TextEditingController();
  }

  void changeSendCodeButtonStatus(ButtonStatusEnum status) {
    sendCodeButtonStatusInput.add(status);
  }

  void dispose() {
    //?dispose streams
    disposeStreams();
  }

  void disposeStreams() {
    //?dispose stream of send code button status
    sendCodeButtonStatusInput.close();
    sendCodeButtonStatusController.close();
  }

  void onChangedTextField(String value) {
    if (forgetPasswordFormKey.currentState!.validate()) {
      changeSendCodeButtonStatus(ButtonStatusEnum.enabled);
    } else {
      changeSendCodeButtonStatus(ButtonStatusEnum.disabled);
    }
  }

  void onTapAtSendCodeButton(BuildContext context) {
    Navigator.of(context).pushNamed(
      RoutesName.otpVerificationScreen,
      arguments: {
        ConstsValuesManager.email: emailController.text,
        ConstsValuesManager.screenName: RoutesName.forgetPassword,
      },
    );
  }
}

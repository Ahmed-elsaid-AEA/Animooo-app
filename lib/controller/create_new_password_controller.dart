import 'dart:async';

import 'package:animooo/core/enums/button_status_enum.dart';
import 'package:animooo/core/functions/app_scaffold_massanger.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/extenstions.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordController {
  //?eye icon of new password
  bool eyeVisibleNewPassword = false;

  //?eye icon of confirm password
  bool eyeVisibleConfirmPassword = false;

  //?controller of text editing
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  //?controller of form key
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //?controller of streams

  //?visible new password
  late StreamController<bool> visibleNewPasswordStreamController;
  late Sink<bool> visibleNewPasswordInput;
  late Stream<bool> visibleNewPasswordOutPutStream;

  //?visible confirm password
  late StreamController<bool> visibleConfirmPasswordStreamController;
  late Sink<bool> visibleConfirmPasswordInput;
  late Stream<bool> visibleConfirmPasswordOutPutStream;

  //?create new password button
  late StreamController<ButtonStatusEnum> submitButtonStreamController;
  late Sink<ButtonStatusEnum> submitButtonInput;
  late Stream<ButtonStatusEnum> submitButtonOutPutStream;

  //?loading screen
  late StreamController<bool> loadingScreenOutputStream;
  late Sink<bool> loadingScreenInput;
  late Stream<bool> loadingScreenOutPutStream;

  final BuildContext context;

  CreateNewPasswordController(this.context) {
    init();
  }

  void init() {
    //?init controller of text editing
    initTextControllers();
    //?init controller of streams
    initStreams();
    //?change button status
    changeSubmitButtonStatus(ButtonStatusEnum.disabled);
  }

  void initTextControllers() {
    //?init controller of text editing
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void initStreams() {
    //?init stream of visible new password
    visibleNewPasswordStreamController = StreamController<bool>();
    visibleNewPasswordOutPutStream = visibleNewPasswordStreamController.stream;
    visibleNewPasswordInput = visibleNewPasswordStreamController.sink;
    //?init stream of visible confirm password
    visibleConfirmPasswordStreamController = StreamController<bool>();
    visibleConfirmPasswordOutPutStream =
        visibleConfirmPasswordStreamController.stream;
    visibleConfirmPasswordInput = visibleConfirmPasswordStreamController.sink;
    //?init stream of submit button
    submitButtonStreamController = StreamController<ButtonStatusEnum>();
    submitButtonOutPutStream = submitButtonStreamController.stream;
    submitButtonInput = submitButtonStreamController.sink;
    //?init stream of loading screen
    loadingScreenOutputStream = StreamController<bool>();
    loadingScreenOutPutStream = loadingScreenOutputStream.stream;
    loadingScreenInput = loadingScreenOutputStream.sink;
  }

  void dispose() {
    //?dispose controller of text editing
    disposeTextControllers();
    //?dispose controller of streams
    disposeStreams();
  }

  void disposeTextControllers() {
    //?dispose controller of text editing
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void disposeStreams() {
    //?dispose stream of visible new password
    visibleNewPasswordStreamController.close();
    visibleNewPasswordInput.close();
    //?dispose stream of visible confirm password
    visibleConfirmPasswordStreamController.close();
    visibleConfirmPasswordInput.close();
    //?dispose stream of submit button
    submitButtonStreamController.close();
    submitButtonInput.close();
    //?dispose stream of loading screen
    loadingScreenOutputStream.close();
    loadingScreenInput.close();
  }

  void onPressedAtEyeNewPassword() {
    eyeVisibleNewPassword = !eyeVisibleNewPassword;
    visibleNewPasswordInput.add(eyeVisibleNewPassword);
  }

  void onPressedAtEyeConfirmPassword() {
    eyeVisibleConfirmPassword = !eyeVisibleConfirmPassword;
    visibleConfirmPasswordInput.add(eyeVisibleConfirmPassword);
  }

  void changeSubmitButtonStatus(ButtonStatusEnum status) {
    submitButtonInput.add(status);
  }

  void onChangedTextField(String value) {
    if (formKey.currentState!.validate()) {
      changeSubmitButtonStatus(ButtonStatusEnum.enabled);
    } else {
      changeSubmitButtonStatus(ButtonStatusEnum.disabled);
    }
  }

  bool checkPasswordAndConfirmPasswordMatch() {
    return newPasswordController.getText == confirmPasswordController.getText;
  }

  void onTapAtSubmitButton() {
    if (checkPasswordAndConfirmPasswordMatch() == true) {
      //?check internet connection
    } else {
      //?show error message
      if (context.mounted) {
        showAppSnackBar(
          context,
          ConstsValuesManager.passwordAndConfirmPasswordMustBeTheSame,
        );
      }
    }
  }
}

//TODO;; go to every screen and dispose streams and controllers

import 'dart:async';

import 'package:animooo/core/di/services/internet_checker_service.dart';
import 'package:animooo/core/enums/widget_status_enum.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/functions/app_navigations.dart';
import 'package:animooo/core/functions/app_scaffold_massanger.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/extenstions.dart';
import 'package:animooo/data/network/auth_api.dart';
import 'package:animooo/models/auth/create_new_password_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/enums/screen_status_state.dart';
import '../core/resources/routes_manager.dart';

class CreateNewPasswordController {
  //?eye icon of new password
  bool eyeVisibleNewPassword = false;

  //?eye icon of confirm password
  bool eyeVisibleConfirmPassword = false;

  //?controller of text editing
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  ScreensStatusState screenState = ScreensStatusState.initial;

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
  late StreamController<WidgetStatusEnum> submitButtonStreamController;
  late Sink<WidgetStatusEnum> submitButtonInput;
  late Stream<WidgetStatusEnum> submitButtonOutPutStream;

  //?loading screen
  late StreamController<bool> loadingScreenOutputStream;
  late Sink<bool> loadingScreenInput;
  late Stream<bool> loadingScreenOutPutStream;

  final BuildContext context;

  CreateNewPasswordController(this.context) {
    init();
  }

  late String email;

  void getArguments() {
    ModalRoute<Object?>? modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      var arguments = modalRoute.settings.arguments;
      if (arguments != null && arguments is Map<String, dynamic>) {
        email = arguments[ConstsValuesManager.email];
      }
    }
  }

  void init() {
    //?init controller of text editing
    initTextControllers();
    //?init controller of streams
    initStreams();
    //?change button status
    changeSubmitButtonStatus(WidgetStatusEnum.disabled);
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
    submitButtonStreamController = StreamController<WidgetStatusEnum>();
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

  void changeSubmitButtonStatus(WidgetStatusEnum status) {
    submitButtonInput.add(status);
  }

  void onChangedTextField(String value) {
    if (formKey.currentState!.validate()) {
      changeSubmitButtonStatus(WidgetStatusEnum.enabled);
    } else {
      changeSubmitButtonStatus(WidgetStatusEnum.disabled);
    }
  }

  bool checkPasswordAndConfirmPasswordMatch() {
    return newPasswordController.getText == confirmPasswordController.getText;
  }

  void onTapAtSubmitButton() async {
    if (checkPasswordAndConfirmPasswordMatch() == true) {
      //?check internet connection
      InternetCheckerService isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();

      if (result == true) {
        //?make api request
        _requestChangePassword();
      } else {
        //?show no internet message
        if (context.mounted) {
          showAppSnackBar(context, ConstsValuesManager.noInternetConnection);
        }
      }
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

  void _requestChangePassword() async {
    screenState = ScreensStatusState.loading;
    changeScreenStateLoading();
    Either<FailureModel, CreateNewPasswordResponse> result =
        await AuthApi.createNewPassword(
          email,
          newPasswordController.getText,
          confirmPasswordController.getText,
        );

    result.fold(
      (FailureModel l) {
        _onFailureRequest(l, context);
      },
      (CreateNewPasswordResponse r) {
        _onSuccessRequest(r, context);
      },
    );
    changeScreenStateLoading();
  }

  void _onFailureRequest(FailureModel l, BuildContext context) {
    screenState = ScreensStatusState.failure;

    String message = _filterErrors(l.errors);
    showAppSnackBar(
      context,
      message,
      onPressedAtRetry: () {
        onTapAtSubmitButton();
      },
    );
  }

  String _filterErrors(List<String> errors) {
    List<String> errorsList = [];
    errors = errors.map((e) => e.toLowerCase().trim()).toList();
    void makeFilter(String contain, String msgError) {
      if (errors.join("").contains(contain.toLowerCase())) {
        errorsList.add(msgError);
      }
    }

    if (errors.isNotEmpty) {
      makeFilter("email is required", ConstsValuesManager.emailIsRequired);
      makeFilter("Not found this email", ConstsValuesManager.notFoundThisEmail);
      makeFilter(
        "password is required",
        ConstsValuesManager.passwordIsRequired,
      );
      makeFilter(
        "confirmPassword",
        ConstsValuesManager.confirmPasswordIsRequired,
      );
      makeFilter("Invalid email", ConstsValuesManager.invalidEmail);
      makeFilter(
        "Password and confirm password not match",
        ConstsValuesManager.passwordAndConfirmPasswordMustBeTheSame,
      );
      makeFilter(
        "Password must be at least 6 characters and include letters and numbers",
        ConstsValuesManager
            .passwordMustBeAtLeastEightCharactersAndContainAtLeastOneUpperCaseLetterOneLowerCaseLetterAndOneNumber,
      );
    }
    return errorsList.join(" , ");
  }

  void changeScreenStateLoading() {
    loadingScreenInput.add(screenState == ScreensStatusState.loading);
  }

  // !@#QWE123qwe
  void _onSuccessRequest(CreateNewPasswordResponse r, BuildContext context) {
    screenState = ScreensStatusState.success;
    AppNavigation.pushNamedAndRemoveUntil(context, RoutesName.loginPage);
  }
}

//TODO;; go to every screen and dispose streams and controllers

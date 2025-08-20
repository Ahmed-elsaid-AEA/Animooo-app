import 'dart:async';

import 'package:animooo/core/di/services/internet_checker_service.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/extenstions.dart';
import 'package:animooo/data/network/auth_api.dart';
import 'package:animooo/models/auth/login_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/enums/button_status_enum.dart';
import '../core/enums/screen_status_state.dart';
import '../core/functions/app_scaffold_massanger.dart';
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

  final BuildContext context;

  LoginScreenController(this.context) {
    init();
  }

  void init() {
    //?init Controllers
    initControllers();
    //?init textControllers
    initTextControllers();
    //?change button status
    changeLoginButtonStatus(ButtonStatusEnum.disabled);
  }

  void changeLoginButtonStatus(ButtonStatusEnum status) {
    loginButtonStatusInput.add(status);
  }

  void initTextControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailController.text = "ahmed122727727@gmail.com";
    passwordController.text = "123!@#QWEqwweewwe";
  }

  void initControllers() {
    //eye stream
    eyeStreamController = StreamController<bool>();
    eyeInput = eyeStreamController.sink;
    eyeVisibleOutPutStream = eyeStreamController.stream;
    //button status stream
    loginButtonStatusController = StreamController<ButtonStatusEnum>();
    loginButtonStatusInput = loginButtonStatusController.sink;
    loginButtonStatusOutPutStream = loginButtonStatusController.stream
        .asBroadcastStream();
    //screen state stream
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateInput = loadingScreenStateController.sink;
    loadingScreenStateOutPutStream = loadingScreenStateController.stream
        .asBroadcastStream();
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

  void onPressedAtForgetPassword() {
    Navigator.of(context).pushNamed(RoutesName.forgetPassword);
  }

  void onPressedAtLoginButton() async {
    if (loginFormKey.currentState!.validate()) {
      //?check network
      InternetCheckerService isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?make api
        _requestLogin();
      } else {
        showAppSnackBar(
          context,
          ConstsValuesManager.noInternetConnection,
          onPressedAtRetry: () {
            onPressedAtLoginButton();
          },
        );
      }
    }
  }

  void onChangeTextFiled(String value) {
    if (loginFormKey.currentState!.validate()) {
      changeLoginButtonStatus(ButtonStatusEnum.enabled);
    } else {
      changeLoginButtonStatus(ButtonStatusEnum.disabled);
    }
  }

  void _requestLogin() async {
    screenState = ScreensStatusState.loading;
    changeLoadingScreenState();
    //?make api
    Either<FailureModel, LoginResponse> response = await AuthApi.login(
      emailController.getText,
      passwordController.getText,
    );

    response.fold(
      (FailureModel l) {
        _onFailureRequest(l, context);
        //Todo :: validate if not verified
      },
      (LoginResponse r) {
        _onSuccessRequest(r, context);
      },
    );
    changeLoadingScreenState();
  }

  void changeLoadingScreenState() {
    loadingScreenStateInput.add(screenState == ScreensStatusState.loading);
  }

  void _onFailureRequest(FailureModel l, BuildContext context) {
    screenState = ScreensStatusState.failure;
    String message = _filterErrors(l.errors);
    showAppSnackBar(
      context,
      message,
      onPressedAtRetry: message.contains(ConstsValuesManager.accountNotVerified)
          ? null
          : () {
              onPressedAtLoginButton();
            },
    );
    if (message.contains(ConstsValuesManager.accountNotVerified)) {
       Navigator.of(context).pushNamed(
        RoutesName.otpVerificationScreen,
        arguments: {
          ConstsValuesManager.email: emailController.getText,
          ConstsValuesManager.screenName: ConstsValuesManager.login,
        },
      );
    }
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
      makeFilter(
        "password is required",
        ConstsValuesManager.passwordIsRequired,
      );
      makeFilter(
        "LateInitializationError: Local 'conn' has not been initialized.",
        ConstsValuesManager.pleaseOpenXamppApp,
      );
      makeFilter(
        "Password or email not true",
        ConstsValuesManager.passwordOrEmailNotCorrect,
      );
      makeFilter(
        "Account not verified",
        ConstsValuesManager.accountNotVerified,
      );
    }

    return errorsList.join(" , ");
  }

  void _onSuccessRequest(LoginResponse r, BuildContext context) {
    screenState = ScreensStatusState.success;
    //?go to verify email screen
    showAppSnackBar(context, r.message ?? "");
    //TODO ::  store token
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.mainPage,
      arguments: {
        ConstsValuesManager.email: emailController.getText,
        ConstsValuesManager.screenName: ConstsValuesManager.signUp,
      },
      (route) => false,
    );
  }
}

import 'dart:async';

import 'package:animooo/core/database/hive/hive_helper.dart';
import 'package:animooo/core/di/services/internet_checker_service.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/functions/app_navigations.dart';
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
  bool rememberMe = false;
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

  //?remember me stream
  late StreamController<bool> rememberMeController;

  late Sink<bool> rememberMeInput;
  late Stream<bool> rememberMeOutPutStream;

  final BuildContext context;

  LoginScreenController(this.context) {
    init();
    //check remember me
  }

  void init() {
    //?init Controllers
    initControllers();
    //?init textControllers
    initTextControllers();
    //?change button status
    changeLoginButtonStatus(ButtonStatusEnum.disabled);
    //?change remember me
    changeRememberMe();
  }

  void changeRememberMe() {
    rememberMeInput.add(rememberMe);
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
    //remember me stream
    rememberMeController = StreamController<bool>();
    rememberMeInput = rememberMeController.sink;
    rememberMeOutPutStream = rememberMeController.stream;
  }

  void dispose() {
    //?dispose streams
    disposeStreams();
  }

  void disposeStreams() {
    eyeStreamController.close();
    eyeInput.close();
    rememberMeController.close();
    rememberMeInput.close();
    loginButtonStatusController.close();
    loginButtonStatusInput.close();
    loadingScreenStateController.close();
    loadingScreenStateInput.close();
  }

  void onPressedAtEye() {
    eyeVisible = !eyeVisible;
    eyeInput.add(eyeVisible);
  }

  void onPressedAtForgetPassword() {
    AppNavigation.pushNamed(context, RoutesName.forgetPasswordPage);
  }

  void onPressedAtLoginButton() async {
    if (loginFormKey.currentState!.validate()) {
      //?check network
      InternetCheckerService isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?make api
        await _requestLogin();
      } else {
        if(context.mounted) {
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
  }

  void onChangeTextFiled(String value) {
    if (loginFormKey.currentState!.validate()) {
      changeLoginButtonStatus(ButtonStatusEnum.enabled);
    } else {
      changeLoginButtonStatus(ButtonStatusEnum.disabled);
    }
  }

  Future<void> _requestLogin() async {
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
      AppNavigation.pushNamed(
        context,
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

  void _onSuccessRequest(LoginResponse r, BuildContext context) async {
    //TODO :: change store token way ( flutter secure storage - shared preferences )
    await _storeToken(accessToken: r.accessToken, refreshToken: r.refreshToken);
    //? store remember me
    await _storeRememberMe();
    screenState = ScreensStatusState.success;
    //?go to verify email screen
    if (context.mounted) showAppSnackBar(context, r.message);
    goToMainPage();
  }

  void goToMainPage() {
    if (context.mounted) {
      AppNavigation.pushNamedAndRemoveUntil(context, RoutesName.mainPage);
    }
  }

  Future<void> _storeToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    HiveHelper<String> hiveHelper = HiveHelper(
      ConstsValuesManager.tokenBoxName,
    );
    //?store access token
    await hiveHelper.addValue(
      key: ConstsValuesManager.accessToken,
      value: "accessToken",
    );
    //?store refresh token
    await hiveHelper.addValue(
      key: ConstsValuesManager.refreshToken,
      value: refreshToken,
    );
  }

  void onChangedRememberMe(bool? value) {
    rememberMe = !rememberMe;
    changeRememberMe();
  }

  Future<void> _storeRememberMe() async {
    HiveHelper<bool> hiveHelper = HiveHelper(
      ConstsValuesManager.rememberMeBoxName,
    );
    await hiveHelper.addValue(
      key: ConstsValuesManager.rememberMe,
      value: rememberMe,
    );
  }
}

//sqflite (relation database)
//hive (non relation database)
//

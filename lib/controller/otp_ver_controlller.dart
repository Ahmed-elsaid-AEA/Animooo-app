import 'dart:async';

import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/functions/app_scaffold_massanger.dart';
import 'package:animooo/models/auth/new_otp_code_response.dart';
import 'package:animooo/models/auth/otp_code_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/enums/screen_status_state.dart';
import '../core/resources/conts_values.dart';
import '../core/resources/routes_manager.dart';
import '../data/network/auth_api.dart';

class OtpVerController {
  late String screenName;
  late String email;
  late Timer _timer;
  int counter = 60;
  String? otpCode;
  ScreensStatusState screenState = ScreensStatusState.initial;

  //?loading state

  late Stream<bool> loadingScreenStateOutPutStream;
  late StreamController<bool> loadingScreenStateController;
  late StreamSink<bool> loadingScreenStateInput;

  //?counter state
  late Stream<int> counterOutPutStream;
  late StreamController<int> counterController;
  late StreamSink<int> counterInput;
  final BuildContext context;

  OtpVerController(this.context) {
    initStreams();
    //?init screen state
    changeScreenStateLoading();
    //?start timer
    startTimer();
  }

  void startTimer() {
    counter = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (counter > 0) {
        counter--;
      } else {
        timer.cancel();
      }
      counterInput.add(counter);
    });
  }

  void initStreams() {
    //?init stream of loading screen state
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateOutPutStream = loadingScreenStateController.stream;
    loadingScreenStateInput = loadingScreenStateController.sink;
    //?init stream of counter
    counterController = StreamController<int>();
    counterOutPutStream = counterController.stream;
    counterInput = counterController.sink;
  }

  void disposeStreams() {
    //?dispose stream of loading screen state
    loadingScreenStateInput.close();
    loadingScreenStateController.close();
    //?dispose stream of counter
    counterInput.close();
    counterController.close();
  }

  void dispose() {
    //?dispose streams
    disposeStreams();
    //?dispose timer
    _timer.cancel();
  }

  void getArguments(BuildContext context) {
    ModalRoute<Object?>? modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      var arguments = modalRoute.settings.arguments;
      if (arguments != null && arguments is Map<String, dynamic>) {
        screenName = arguments[ConstsValuesManager.screenName];
        email = arguments[ConstsValuesManager.email];
      }
    }
    if (screenName == ConstsValuesManager.login) {
      _requestNewOtpCode(context);
    }
  }

  void startOtpCheck(String value) {
    otpCode = value;
  }

  void changeScreenStateLoading() {
    loadingScreenStateInput.add(screenState == ScreensStatusState.loading);
  }

  void onPressedConfirmButton() async {
    //?check code is not null
    if (otpCode != null) {
      screenState = ScreensStatusState.loading;
      changeScreenStateLoading();
      //?check internet connection
      var isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?now make api request
        _requestCheckOtpCodeAvailability(context);
      } else {
        _showNoInternetSnackBar(context);
      }
      screenState = ScreensStatusState.success;
      changeScreenStateLoading();
      //?go to create new password after request on api
    } else {
      showAppSnackBar(context, 'Please enter code');
    }
  }

  void _requestCheckOtpCodeAvailability(BuildContext context) async {
    //? 1 - show loading

    changeScreenStateLoading();

    Either<FailureModel, OtpCodeResponse> response =
        await AuthApi.checkOtpAvailability(email, otpCode!);

    response.fold(
      (FailureModel l) {
        _onFailureRequest(l, context);
      },
      (OtpCodeResponse r) {
        otpOnSuccessRequest(r, context);
      },
    );
    changeScreenStateLoading();
  }

  void _showNoInternetSnackBar(BuildContext context) {
    screenState = ScreensStatusState.failure;
    changeScreenStateLoading();
    showAppSnackBar(
      context,
      'No internet connection',
      onPressedAtRetry: () {
        onPressedConfirmButton();
      },
    );
  }

  void _onFailureRequest(FailureModel l, BuildContext context) {
    screenState = ScreensStatusState.failure;
    String message = _filterErrors(l.errors);
    showAppSnackBar(
      context,
      message,
      onPressedAtRetry: () {
        onPressedConfirmButton();
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
      makeFilter(
        "Invalid verfication code",
        ConstsValuesManager.invalidVerificationCode,
      );
      makeFilter("Database error", ConstsValuesManager.databaseError);
    }
    return errorsList.join(" , ");
  }

  void otpOnSuccessRequest(OtpCodeResponse r, BuildContext context) {
    screenState = ScreensStatusState.success;
    //go to sign in page
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.loginPage,
      (route) => false,
    );
  }

  void onPressedResendCodeButton() async {
    //?check code is not null

    screenState = ScreensStatusState.loading;
    changeScreenStateLoading();
    //?check internet connection
    var isInternetConnected = InternetCheckerService();
    bool result = await isInternetConnected();
    if (result == true) {
      //?now make api request
      _requestNewOtpCode(context);
    } else {
      _showNoInternetSnackBar(context);
      screenState = ScreensStatusState.failure;
      changeScreenStateLoading();
    }

    //?go to create new password after request on api
  }

  void _requestNewOtpCode(BuildContext context) async {
    //? 1 - show loading

    Either<FailureModel, NewOtpCodeResponse> response =
        await AuthApi.resendCOtpCode(email);

    response.fold(
      (FailureModel l) {
        _onFailureRequest(l, context);
      },
      (NewOtpCodeResponse r) {
        //?solve this error
        showAppSnackBar(context, ConstsValuesManager.resendCodeSuccessfully);
        screenState = ScreensStatusState.success;
        startTimer();
      },
    );
    changeScreenStateLoading();
  }
}

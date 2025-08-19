import 'dart:async';

import 'package:animooo/core/functions/app_scaffold_massanger.dart';
import 'package:flutter/cupertino.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/enums/screen_status_state.dart';
import '../core/resources/conts_values.dart';

class OtpVerController {
  late String screenName;
  late String email;
  String? otpCode;
  ScreensStatusState screenState = ScreensStatusState.initial;

  late Stream<bool> loadingScreenStateOutPutStream;
  late StreamController<bool> loadingScreenStateController;
  late StreamSink<bool> loadingScreenStateInput;
  final BuildContext context;

  OtpVerController(this.context) {
    initStreams();
    //?init screen state
    changeScreenStateLoading();
  }

  void initStreams() {
    //?init stream of loading screen state
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateOutPutStream = loadingScreenStateController.stream;
    loadingScreenStateInput = loadingScreenStateController.sink;
  }

  void disposeStreams() {
    //?dispose stream of loading screen state
    loadingScreenStateInput.close();
    loadingScreenStateController.close();
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
  }

  void startOtpCheck(String value) {
    otpCode = value;
  }

  void changeScreenStateLoading() {
    loadingScreenStateInput.add(screenState == ScreensStatusState.loading);
  }

  void onPressedConfirmButton() async {
    screenState = ScreensStatusState.loading;
    changeScreenStateLoading();
    //?check internet connection
    var isInternetConnected = InternetCheckerService();
    bool result = await isInternetConnected();
    if (result == true) {
      //?now make api request
      // _requestCheckOtpCodeAvailablity(context);
    } else {
      _showNoInternetSnackBar(context);
    }
    screenState = ScreensStatusState.success;
    changeScreenStateLoading();
    //?go to create new password after request on api
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
}

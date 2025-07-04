import 'package:animooo/controller/otp_ver_controlller.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/widgets/app_Bar/simple_app_bar.dart';
import 'package:animooo/core/widgets/loading/app_model_progress_hud.dart';
import 'package:flutter/material.dart';

import '../../../core/enums/screen_status_state.dart';
import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../../../core/widgets/verifications/app_otp_verification_text_field.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late OtpVerController _otpVerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _otpVerController = OtpVerController();
  }
  @override
  Widget build(BuildContext context) {
    _otpVerController.getArguments(context);

    return AppModelProgressHud(
      loadingOutputStream: _otpVerController.loadingScreenStateOutPutStream,
      child: Scaffold(
        appBar: SimpleAppBar(title: ConstsValuesManager.cancel),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: PaddingManager.pw18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpace(HeightsManager.h9_15),
                  Text(
                    ConstsValuesManager.otpVerification,
                    style: TextStyle(
                      fontFamily: FontsManager.otamaEpFontFamily,
                      fontSize: FontSizeManager.s20,
                      color: ColorManager.kPrimaryColor,
                    ),
                  ),
                  VerticalSpace(HeightsManager.h6),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: PaddingManager.pw4,
                    ),
                    child: Text(
                      style: TextStyle(
                        fontFamily: FontsManager.poppinsFontFamily,
                        fontSize: FontSizeManager.s14,
                        color: ColorManager.kGrey4Color,
                      ),
                      ConstsValuesManager
                          .pleaseEnterThe4DigitCodeSentYourPhoneNumber,
                    ),
                  ),
                  VerticalSpace(HeightsManager.h41),
                  AppOtpVerificationTextField(
                    onCompleted: (String value) {
                      //?go to create new password after request on api
      _otpVerController.startOtpCheck(value);
                    },
                  ),
                  VerticalSpace(HeightsManager.h41),
                  AppButton(
                    text: ConstsValuesManager.confirm,
                    onTap: () async {
                      _otpVerController.screenState = ScreensStatusState.loading;
                      _otpVerController.changeScreenStateLoading();
                     await Future.delayed(const Duration(seconds: 2));

                      _otpVerController.screenState = ScreensStatusState.success;
                      _otpVerController.changeScreenStateLoading();
                      //?go to create new password after request on api
                    },
                  ),
                  VerticalSpace(HeightsManager.h6),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      ConstsValuesManager.resendCodeIn,
                      style: TextStyle(
                        fontFamily: FontsManager.poppinsFontFamily,
                        fontSize: FontSizeManager.s12,
                        color: ColorManager.kBlackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // verification code
  }
}

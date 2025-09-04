import 'package:animooo/controller/otp_ver_controlller.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/widgets/app_Bar/simple_app_bar.dart';
import 'package:animooo/core/widgets/loading/app_model_progress_hud.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
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
    _otpVerController = OtpVerController(context);
  }

  @override
  void dispose() {
    _otpVerController.dispose();
    super.dispose();
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
                    onTap: _otpVerController.onPressedConfirmButton,
                  ),
                  VerticalSpace(HeightsManager.h6),
                  Align(
                    alignment: Alignment.center,
                    child: StreamBuilder<int>(
                      initialData: 59,
                      stream: _otpVerController.counterOutPutStream,
                      builder: (context, snapshot) => TextButton(
                        onPressed: snapshot.data != 0
                            ? null
                            : _otpVerController.onPressedResendCodeButton,
                        child: Text(
                          "${ConstsValuesManager.resendCodeIn} 00:${snapshot.data.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontFamily: FontsManager.poppinsFontFamily,
                            fontSize: FontSizeManager.s12,
                            color: snapshot.data != 0
                                ? ColorManager.kGrey3Color
                                : ColorManager.kGreenColor,
                          ),
                        ),
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

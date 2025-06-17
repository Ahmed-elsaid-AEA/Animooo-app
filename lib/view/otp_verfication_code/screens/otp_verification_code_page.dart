import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/app_Bar/simple_app_bar.dart';
import 'package:animooo/core/widgets/custom_text_form_field.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/border_radius_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../../../core/widgets/verifications/app_otp_verification_text_field.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.of(context).pushNamed(
                      RoutesName.createNewPassword,
                    );
                  },
                ),
                VerticalSpace(HeightsManager.h41),
                AppButton(
                  text: ConstsValuesManager.confirm,
                  onTap: () {
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
    );
    // verification code
  }
}

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
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

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
                AppOtpVerificationTextField(),
                VerticalSpace(HeightsManager.h41),
                AppButton(
                  text: ConstsValuesManager.confirm,
                  onTap: () {
                    //?go to otp page
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

class AppOtpVerificationTextField extends StatefulWidget {
  const AppOtpVerificationTextField({super.key});

  @override
  State<AppOtpVerificationTextField> createState() =>
      _AppOtpVerificationTextFieldState();
}

class _AppOtpVerificationTextFieldState
    extends State<AppOtpVerificationTextField> {
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;
  late TextEditingController controller5;
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();

    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    controller5 = TextEditingController();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();

    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(focusNode1);
  }

  void goToNextFocusNode(
    String value,
    FocusNode focusNode,
    TextEditingController controller,
  ) {
    if (value.trim().isNotEmpty) {
      if (value.length > 1) {
        controller.text = value[value.length - 1];
      }
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            onChanged: (value) {
              goToNextFocusNode(value, focusNode2, controller1);
            },
            controller: controller1,
            focusNode: focusNode1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w18),
        Expanded(
          child: CustomTextFormField(
            onChanged: (value) {
              goToNextFocusNode(value, focusNode3, controller2);
            },
            controller: controller2,
            focusNode: focusNode2,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w18),
        Expanded(
          child: CustomTextFormField(
            focusNode: focusNode3,
            textAlign: TextAlign.center,
            onChanged: (value) {
              goToNextFocusNode(value, focusNode4, controller3);
            },
            controller: controller3,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w18),
        Expanded(
          child: CustomTextFormField(
            focusNode: focusNode4,
            textAlign: TextAlign.center,
            onChanged: (value) {
              goToNextFocusNode(value, focusNode5, controller4);
            },
            controller: controller4,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w18),
        Expanded(
          child: CustomTextFormField(
            onChanged: (value) {
              if (value.trim().isNotEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('ConstsValuesManager.warning'),
                      content: Text('ConstsValuesManager.pleaseEnterTheCode'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('ok'),
                        ),
                      ],
                    );
                  },
                );
              }
              if (value.length > 1) {
                controller5.text = value[value.length - 1];
              }
            },
            focusNode: focusNode5,
            controller: controller5,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
      ],
    );
  }
}

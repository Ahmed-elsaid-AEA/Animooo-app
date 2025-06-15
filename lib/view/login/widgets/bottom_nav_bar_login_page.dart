import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart' show ConstsValuesManager;
import '../../../core/resources/padding_manager.dart' show PaddingManager;
import '../../../core/resources/width_manager.dart';
import '../../../core/widgets/spacing/horizontal_space.dart';

class BottomNavBarLoginPage extends StatelessWidget {
  const BottomNavBarLoginPage({super.key,required this.onPressedSignUpNow});

  final void Function()? onPressedSignUpNow;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: PaddingManager.ph8,
        horizontal: PaddingManager.ph18,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontFamily: FontsManager.poppinsFontFamily,
            fontSize: FontSizeManager.s14,
          ),
          children: [
            TextSpan(
              text: ConstsValuesManager.dontHaveAnAccount,
              style: TextStyle(
                color: ColorManager.kGrey3Color,
                fontWeight: FontWeight.w300,
              ),
            ),
            WidgetSpan(child: HorizontalSpace(width: WidthManager.w4)),
            TextSpan(
              text: ConstsValuesManager.signUpNow,
              style: TextStyle(
                color: ColorManager.kPrimaryColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = onPressedSignUpNow,
            ),
          ],
        ),
      ),
    );
  }
}

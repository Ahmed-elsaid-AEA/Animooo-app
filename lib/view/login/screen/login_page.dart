import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/border_radius_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/app_logo_and_title_widget.dart';
import 'package:animooo/core/widgets/custom_text_form_field.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/padding_manager.dart' show PaddingManager;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingManager.pw18),
            child: Column(
              children: [
                AppLogoAndTitleWidget(),
                VerticalSpace(height: HeightsManager.h9_15),
                Text(
                  ConstsValuesManager.login,
                  style: TextStyle(
                    fontFamily: FontsManager.otamaEpFontFamily,
                    fontSize: FontSizeManager.s38_21,
                    color: ColorManager.kBlackColor,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstsValuesManager.email,
                    style: TextStyle(
                      fontSize: FontSizeManager.s16,
                      color: ColorManager.kGreyColor,
                      fontFamily: FontsManager.poppinsFontFamily,
                    ),
                  ),
                ),
                VerticalSpace(height: HeightsManager.h6),
                CustomTextFormField(
                  hintText: ConstsValuesManager.enterYourEmailAddress,
                ),
                VerticalSpace(height: HeightsManager.h16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ConstsValuesManager.password,
                    style: TextStyle(
                      fontSize: FontSizeManager.s16,
                      color: ColorManager.kGreyColor,
                      fontFamily: FontsManager.poppinsFontFamily,
                    ),
                  ),
                ),
                VerticalSpace(height: HeightsManager.h6),
                CustomTextFormField(
                  obscureText: true,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.eye,
                      color: ColorManager.kGrey2Color,
                    ),
                  ),
                  hintText: ConstsValuesManager.enterYourPassword,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      ConstsValuesManager.forgotPassword,
                      style: TextStyle(
                        color: ColorManager.kPrimaryColor,
                        fontSize: FontSizeManager.s10,
                        decoration: TextDecoration.underline,
                        fontFamily: FontsManager.poppinsFontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                VerticalSpace(height: HeightsManager.h31),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          BorderRadiusManager.br10,
                        ),
                      ),
                    ),
                    child: Text(
                      ConstsValuesManager.login,
                      style: TextStyle(
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontsManager.poppinsFontFamily,
                        fontSize: FontSizeManager.s14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontFamily: FontsManager.poppinsFontFamily,
            fontSize: FontSizeManager.s14,
          ),
          children: [

            TextSpan(
              text: ConstsValuesManager.dontHaveAnAccount,
              style: TextStyle(color: ColorManager.kGrey3Color,fontWeight: FontWeight.w300),
            ),
            TextSpan(text: ConstsValuesManager.signUpNow, style: TextStyle(
              color: ColorManager.kPrimaryColor,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold
            )),
          ],
        ),
      ),
    );
  }
}

import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SvgPicture.asset(
                AssetsValuesManager.appLogoSVG,
                width: WidthManager.w72,
              ),
              Text(
                ConstsValuesManager.animooo,
                style: TextStyle(
                  fontFamily: FontsManager.originalSurferFontFamily,
                  fontSize: FontSizeManager.s11_44,
                  color: ColorManager.kPrimaryColor
                ),
              ),
             VerticalSpace(height: HeightsManager.h9_15)
              ,Text(
                ConstsValuesManager.login,
                style: TextStyle(
                    fontFamily: FontsManager.otamaEpFontFamily,
                    fontSize: FontSizeManager.s38_21,
                    color: ColorManager.kBlackColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

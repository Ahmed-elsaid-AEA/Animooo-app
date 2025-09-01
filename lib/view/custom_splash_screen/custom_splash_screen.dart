import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/app_logo_and_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/database/hive/hive_helper.dart';
import '../../core/resources/conts_values.dart';
import '../../core/resources/fonts_size_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/resources/routes_manager.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  Future<void> checkRememberMe() async {
    HiveHelper<bool> hiveHelper = HiveHelper(
      ConstsValuesManager.rememberMeBoxName,
    );
    bool rememberMe =
        await hiveHelper.getValue(key: ConstsValuesManager.rememberMe) ?? false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        rememberMe == true ? RoutesName.mainPage : RoutesName.loginPage,
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 100,
        child: SpinKitThreeBounce(color: Colors.white, size: 20.0),
      ),

      backgroundColor: ColorManager.kPrimaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsValuesManager.appLogoSVG, width: 200.w),
            Text(
              ConstsValuesManager.animooo,
              style: TextStyle(
                fontFamily: FontsManager.originalSurferFontFamily,
                fontSize: FontSizeManager.s28,
                color: ColorManager.kWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

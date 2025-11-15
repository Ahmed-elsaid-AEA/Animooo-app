import 'package:animooo/core/database/shared_pref/shared_pref_manager.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/functions/app_navigations.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/widgets/app_logo_and_title_widget.dart';
import 'package:flutter/material.dart';
import '../../core/database/hive/hive_helper.dart';
import '../../core/resources/conts_values.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/resources/routes_manager.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  Future<void> checkRememberMe() async {
    bool rememberMe =
        await getIt<SharedPrefManager>().readData(
          ConstsValuesManager.rememberMe,
        ) ??
        false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppNavigation.pushNamedAndRemoveUntil(
        context,
        rememberMe == true ? RoutesName.mainPage : RoutesName.loginPage,
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
      body: Center(
        child: AppLogoAndTitleWidget(
          aspectRatio: 3.5,
          color: ColorManager.kWhiteColor,
        ),
      ),
    );
  }
}

import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimoooApp extends StatelessWidget {
  const AnimoooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,

      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: getIt<GlobalKey<NavigatorState>>(
            instanceName: ConstsValuesManager.appNavigationState,
          ),
          theme: ThemeData().copyWith(
            scaffoldBackgroundColor: ColorManager.kWhiteColor,
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.onGenerateRoute,
        );
      },
    );
  }
}

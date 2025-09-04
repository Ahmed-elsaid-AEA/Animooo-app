import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/functions/app_navigations.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/routes_manager.dart';
import 'package:flutter/cupertino.dart';

class HomePageController {
  static HomePageController? _instance;

  HomePageController._internal() {
    //?
    print("HomePageController");
    // init();
  }

  factory HomePageController() {
    return _instance ??= HomePageController._internal();
  }

  void onPressedAtSeeMore(BuildContext context) {
    print("done");
    GlobalKey<NavigatorState> navigatorKey = getIt<GlobalKey<NavigatorState>>(
      instanceName: ConstsValuesManager.homePageNavigationState,
    );
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.pushNamed(
        RoutesName.categoryPageDetails.route,
      );
    } else {
      AppNavigation.pushNamed(context, RoutesName.categoryPageDetails);
    }
  }
}

import 'package:animooo/controller/main_page_controller.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/functions/app_navigations.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/routes_manager.dart';
import 'package:flutter/cupertino.dart';

import '../view/main_page/screen/main_page.dart';

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

  void goToCategoryTapPage() {
    // MainPageController mainPageController = MainPageController(context);
    // mainPageController.onTapBottomNavigationBarItem(2);
    mainPageKey.currentState?.mainPageController.onTapBottomNavigationBarItem(
      2,
    );
  }

  void goToAnimalTapPage() {
    mainPageKey.currentState?.mainPageController.onTapBottomNavigationBarItem(
      3,
    );
  }
}

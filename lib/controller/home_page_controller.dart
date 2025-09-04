import 'package:animooo/core/di/get_it.dart';
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
    Navigator.pushNamed(context, RoutesName.categoryPageDetails);

  }
}

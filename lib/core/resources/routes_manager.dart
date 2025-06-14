import 'package:animooo/core/widgets/unknow_route_page.dart';
import 'package:animooo/view/signup/screen/sign_up_page.dart';
import 'package:flutter/material.dart';

import '../../view/login/screen/login_page.dart';

class RoutesManager {
  static Route? onGenerateRoute(RouteSettings settings) {
    Widget widget;
    switch (settings.name) {
      case RoutesName.loginPage:
        widget = LoginPage();
      case RoutesName.signupPage:
        widget = SignUpPage();
      default:
        widget = const UnknownRoutePage();
    }
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}

class RoutesName {
  static const String loginPage = '/';
  static const String signupPage = '/signup';
}

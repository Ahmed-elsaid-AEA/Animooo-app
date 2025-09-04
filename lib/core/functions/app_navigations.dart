import 'package:animooo/core/resources/routes_manager.dart';
import 'package:flutter/cupertino.dart';

class AppNavigation {
  AppNavigation._();

  static void pushNamed(
    BuildContext context,
    RoutesName routeName, {
    Object? arguments,
    bool rootNavigator = false,
  }) {
    Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).pushNamed(routeName.route, arguments: arguments);
  }

  static void pop(BuildContext context, {bool rootNavigator = false}) {
    Navigator.of(context, rootNavigator: rootNavigator).pop();
  }

  static void pushReplacementNamed(
    BuildContext context,
    RoutesName routeName, {
    Object? arguments,
    bool rootNavigator = false,
  }) {
    Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).pushReplacementNamed(routeName.route, arguments: arguments);
  }

  static void pushNamedAndRemoveUntil(
    BuildContext context,
    RoutesName routeName, {
    Object? arguments,
    bool rootNavigator = false,
  }) {
    Navigator.of(context, rootNavigator: rootNavigator).pushNamedAndRemoveUntil(
      routeName.route,
      (route) => false,
      arguments: arguments,
    );
  }

  static void popUntil(BuildContext context, {bool rootNavigator = false}) {
    Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).popUntil((route) => route.isFirst);
  }
}

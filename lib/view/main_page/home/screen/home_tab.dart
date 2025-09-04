import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/view/main_page/category_detail/screen/category_detail_page.dart';
import 'package:animooo/view/main_page/home/screen/home_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/widgets/unknow_route_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: getIt<GlobalKey<NavigatorState>>(
        instanceName: ConstsValuesManager.homePageNavigationState,
      ),
      onGenerateRoute: (settings) {
        Widget widget;
        switch (settings.name) {
          case RoutesName.categoryPageDetails:
            widget = CategoryDetailPage();
          case RoutesName.slash:
            widget = HomePage();
          default:
            widget = const UnknownRoutePage();
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return widget;
          },
        );
      },
    );
  }
}

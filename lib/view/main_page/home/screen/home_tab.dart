import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/view/main_page/category_detail/screen/category_detail_page.dart';
import 'package:animooo/view/main_page/home/screen/home_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/widgets/unknow_route_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("build home tab");
    return Navigator(
      key: getIt<GlobalKey<NavigatorState>>(
        instanceName: ConstsValuesManager.homePageNavigationState,
      ),
      onGenerateRoute: (settings) {
        print("${settings.name}");
        Widget widget;
        if (settings.name == RoutesName.categoryPageDetails.route) {
          widget = CategoryDetailPage();
        } else if (settings.name == RoutesName.slash.route) {
          widget = HomePage();
        } else {
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

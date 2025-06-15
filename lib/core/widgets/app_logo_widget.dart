import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_values_manager.dart';
import '../resources/width_manager.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsValuesManager.appLogoSVG,
      width: WidthManager.w72,
    );
  }
}
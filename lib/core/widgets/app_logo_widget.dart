import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_values_manager.dart';
import '../resources/width_manager.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key, this.aspectRatio = 1});

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsValuesManager.appLogoSVG,
      width: WidthManager.w72 * aspectRatio,
    );
  }
}

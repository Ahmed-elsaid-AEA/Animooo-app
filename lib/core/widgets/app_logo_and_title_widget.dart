import 'package:flutter/material.dart';

import '../resources/assets_values_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/conts_values.dart';
import '../resources/fonts_size_manager.dart';
import 'app_logo_widget.dart';

class AppLogoAndTitleWidget extends StatelessWidget {
  const AppLogoAndTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppLogoWidget(),
        Text(
          ConstsValuesManager.animooo,
          style: TextStyle(
            fontFamily: FontsManager.originalSurferFontFamily,
            fontSize: FontSizeManager.s11_44,
            color: ColorManager.kPrimaryColor,
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/resources/width_manager.dart';
import '../../../core/widgets/app_logo_widget.dart';
import '../../../core/widgets/spacing/horizontal_space.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: PaddingManager.pw16,
      ),
      child: Row(
        children: [
          AppLogoWidget(),
          HorizontalSpace(WidthManager.w24),
          Text(
            ConstsValuesManager.kHelloInAnimooo,
            style: TextStyle(
              fontSize: FontSizeManager.s24,
              fontFamily: FontsManager.originalSurferFontFamily,
              color: ColorManager.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

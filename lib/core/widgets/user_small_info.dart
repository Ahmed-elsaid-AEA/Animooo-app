import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/material.dart';

import '../resources/assets_values_manager.dart';
import '../resources/border_radius_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/conts_values.dart';
import '../resources/fonts_size_manager.dart';
import '../resources/heights_manager.dart';
import '../resources/padding_manager.dart';
import '../resources/width_manager.dart';

class UserSmallINfo extends StatelessWidget {
  const UserSmallINfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: BorderRadiusManager.br18,
          backgroundImage: AssetImage(
            AssetsValuesManager.backgroundSplashScreenUnder12,
          ),
        ),
        HorizontalSpace(WidthManager.w6),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ahmed Elsaid",
              style: TextStyle(
                fontFamily: FontsManager.otamaEpFontFamily,
                fontSize: FontSizeManager.s12,
                color: ColorManager.kBlackColor,
              ),
            ),
            VerticalSpace(HeightsManager.h4),
            Container(
              padding: EdgeInsets.all(PaddingManager.ph5),
              decoration: BoxDecoration(
                color: ColorManager.kLightGreenColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(BorderRadiusManager.br32),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.public,
                    size: 10,
                    color: ColorManager.kLightGreenColor,
                  ),
                  HorizontalSpace(WidthManager.w3),
                  Text(
                    ConstsValuesManager.public,
                    style: TextStyle(
                      fontSize: FontSizeManager.s10,
                      color: ColorManager.kLightGreenColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

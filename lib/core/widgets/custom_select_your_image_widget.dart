import 'package:animooo/core/resources/border_radius_manager.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/assets_values_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/conts_values.dart';
import '../resources/fonts_size_manager.dart';
import '../resources/heights_manager.dart';
import '../resources/padding_manager.dart';

class CustomSelectImageWidget extends StatelessWidget {
  const CustomSelectImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          padding: EdgeInsets.symmetric(
            vertical: PaddingManager.ph67,
            horizontal: PaddingManager.pw20,
          ),
          radius: Radius.circular(BorderRadiusManager.br10),
          color: ColorManager.kPrimaryColor,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image, color: ColorManager.kPrimaryColor, size: FontSizeManager.s28),
              VerticalSpace(HeightsManager.h16),
              Text(
                ConstsValuesManager.selectYourImage,
                style: TextStyle(
                  color: ColorManager.kPrimaryColor,
                  fontSize: FontSizeManager.s16,
                  fontFamily: FontsManager.poppinsFontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../resources/border_radius_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/conts_values.dart';
import '../resources/fonts_size_manager.dart';
import '../resources/heights_manager.dart';
import '../widgets/buttons/app_button.dart';
import '../widgets/spacing/vertical_space.dart';

Future<void> showSelectImageModelBottomSheet(
  BuildContext context,
  void Function() onTapAtCamera,
  void Function() onTapAtGallery,
) async {
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(BorderRadiusManager.br5),
              topRight: Radius.circular(BorderRadiusManager.br5),
            ),
            text: ConstsValuesManager.camera,
            onTap: onTapAtCamera,
            textColor: ColorManager.kPrimaryColor,
            fontSize: FontSizeManager.s18,
            backgroundColor: ColorManager.kWhiteColor,
            height: HeightsManager.h61,
          ),
          Divider(thickness: 1, height: 1, color: Color(0xffD8D8D8)),
          AppButton(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(BorderRadiusManager.br5),
              bottomRight: Radius.circular(BorderRadiusManager.br5),
            ),
            text: ConstsValuesManager.gallery,
            onTap: onTapAtGallery,
            textColor: ColorManager.kPrimaryColor,
            fontSize: FontSizeManager.s18,
            backgroundColor: ColorManager.kWhiteColor,
            height: HeightsManager.h61,
          ),
          VerticalSpace(HeightsManager.h10),
          AppButton(
            text: ConstsValuesManager.cancel,
            onTap: () {
              print("object");
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            textColor: ColorManager.kPrimaryColor,
            fontSize: FontSizeManager.s18,
            backgroundColor: ColorManager.kWhiteColor,
            height: HeightsManager.h61,
          ),
        ],
      );
    },
  );
}

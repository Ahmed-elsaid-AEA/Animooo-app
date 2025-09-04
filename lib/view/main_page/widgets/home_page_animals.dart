import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/border_radius_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/padding_manager.dart';

class HomePageAnimals extends StatelessWidget {
  const HomePageAnimals({
    super.key,
    required this.onPressedAddNewCategory,
    required this.onPressedAtSeeMore,
  });

  final VoidCallback onPressedAddNewCategory;
  final VoidCallback onPressedAtSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: PaddingManager.pw16,
          ),
          child: _TitleAnimal(onPressedAddNewAnimal: onPressedAddNewCategory),
        ),
        VerticalSpace(HeightsManager.h13),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => _AnimalCard(),
          separatorBuilder: (context, index) =>
              VerticalSpace(HeightsManager.h17),
          itemCount: 5,
        ),
      ],
    );
  }
}

class _AnimalCard extends StatelessWidget {
  const _AnimalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.kLightWhiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusManager.br8),
        ),
      ),
      margin: EdgeInsetsGeometry.symmetric(horizontal: PaddingManager.pw16),
      padding: EdgeInsetsGeometry.only(top: PaddingManager.ph12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: PaddingManager.pw8,
              vertical: PaddingManager.ph12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dog name",
                      style: TextStyle(
                        fontSize: FontSizeManager.s12,
                        fontFamily: FontsManager.otamaEpFontFamily,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.kBlackColor,
                      ),
                    ),
                    Text(
                      "Created by Ahmed Elsaid",
                      style: TextStyle(
                        fontSize: FontSizeManager.s12,
                        fontFamily: FontsManager.poppinsFontFamily,
                        color: ColorManager.kGrey5Color,
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(Icons.more_vert_rounded),
                        ),
                      ),
                    ],
                    text: "1000\$",
                    style: TextStyle(
                      color: ColorManager.kPrimaryColor,
                      fontSize: FontSizeManager.s12,
                      fontFamily: FontsManager.otamaEpFontFamily,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            AssetsValuesManager.backgroundSplashScreenUnder12,
            height: HeightsManager.h173,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(
              left: PaddingManager.pw8,
              right: PaddingManager.pw8,
              top: PaddingManager.ph12,
              bottom: PaddingManager.ph5,
            ),
            child: Text(
              style: TextStyle(
                fontSize: FontSizeManager.s12,
                fontFamily: FontsManager.poppinsFontFamily,
                color: ColorManager.kBlackColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              "I found this sweet dog and am looking for a loving  home for them. If you're ready to welcome a new furry friend into your life, this adorable pup is waiting to bring joy and...",
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleAnimal extends StatelessWidget {
  const _TitleAnimal({required this.onPressedAddNewAnimal});

  final VoidCallback onPressedAddNewAnimal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: PaddingManager.pw6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${ConstsValuesManager.animals} ( 20 )",
            //TODO: add count animals
            style: TextStyle(
              fontSize: FontSizeManager.s16,
              fontFamily: FontsManager.poppinsFontFamily,
              fontWeight: FontWeight.w600,
              color: ColorManager.kBlackColor,
            ),
          ),
          TextButton(
            onPressed: onPressedAddNewAnimal,
            child: Text(
              ConstsValuesManager.addNewAnimal,
              style: TextStyle(
                fontSize: FontSizeManager.s12,
                fontFamily: FontsManager.otamaEpFontFamily,
                color: ColorManager.kBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

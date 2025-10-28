import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/border_radius_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:animooo/models/animal/animal_response_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/enums/widget_status_enum.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/resources/width_manager.dart';

class HomePageAnimals extends StatelessWidget {
  const HomePageAnimals({
    super.key,
    required this.onPressedAddNewAnimal,
    required this.onPressedAtSeeMore,
    required this.listAnimalOutPut,
    required this.sectionAnimalStatusOutput,
    required this.onTapAtItemAnimal,
  });

  final VoidCallback onPressedAddNewAnimal;
  final VoidCallback onPressedAtSeeMore;
  final Stream<List<AnimalInfoResponseModel>> listAnimalOutPut;

  final Stream<WidgetStatusEnum> sectionAnimalStatusOutput;
  final void Function(AnimalInfoResponseModel category) onTapAtItemAnimal;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: PaddingManager.pw16,
          ),
          child: StreamBuilder<List<AnimalInfoResponseModel>>(
            stream: listAnimalOutPut,
            initialData: [],
            builder: (context, snapshot) => _TitleAnimal(
              onPressedAddNewAnimal: onPressedAddNewAnimal,
              count: snapshot.data!.length,
            ),
          ),
        ),
        VerticalSpace(HeightsManager.h13),
        StreamBuilder<WidgetStatusEnum>(
          stream: sectionAnimalStatusOutput,
          builder: (context, snapShotStatus) {
            return IndexedStack(
              index: snapShotStatus.data == WidgetStatusEnum.loading ? 0 : 1,
              children: [
                _LoadingItemAnimal(),
                HaveItemAnimal(listAnimalOutPut: listAnimalOutPut),
              ],
            );
            // return snapShotStatus.data == WidgetStatusEnum.loading
            //     ? FlutterLogo()
            //     : Container(
            //   color: Colors.red,
            //       child: HaveItemCategories(
            //           listCategoriesOutput: listCategoriesOutput,
            //         ),
            //     );
          },
        ),
      ],
    );
  }
}

class HaveItemAnimal extends StatelessWidget {
  const HaveItemAnimal({super.key, required this.listAnimalOutPut});

  final Stream<List<AnimalInfoResponseModel>> listAnimalOutPut;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AnimalInfoResponseModel>>(
      initialData: [],
      stream: listAnimalOutPut,
      builder: (context, asyncSnapshot) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              _AnimalCard(animal: asyncSnapshot.data![index]),
          separatorBuilder: (context, index) =>
              VerticalSpace(HeightsManager.h17),
          itemCount: asyncSnapshot.data!.length,
        );
      },
    );
  }
}

class _LoadingItemAnimal extends StatelessWidget {
  const _LoadingItemAnimal({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => _LoadingAnimalCard(),
      separatorBuilder: (context, index) => VerticalSpace(HeightsManager.h17),
      itemCount: 5,
    );
  }
}

class _AnimalCard extends StatelessWidget {
  const _AnimalCard({required this.animal});

  final AnimalInfoResponseModel animal;

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
                      animal.animalName,
                      style: TextStyle(
                        fontSize: FontSizeManager.s12,
                        fontFamily: FontsManager.otamaEpFontFamily,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.kBlackColor,
                      ),
                    ),
                    Text(
                      "Created by ${animal.userId}",
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
                    text: "${animal.animalPrice}\$",
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
          Image.network(
            //todo:: use cash network image
            animal.animalImage,
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
              animal.animalDescription,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingAnimalCard extends StatelessWidget {
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
              horizontal: PaddingManager.pw4,
              vertical: PaddingManager.ph4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(top: PaddingManager.ph4),
                        color: Colors.red,
                        width: WidthManager.w56,
                        height: HeightsManager.h14,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(top: PaddingManager.ph4),
                        color: Colors.red,
                        width: WidthManager.w131,
                        height: HeightsManager.h14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(top: PaddingManager.ph4),
                        color: Colors.red,
                        width: WidthManager.w33,
                        height: HeightsManager.h14,
                      ),
                    ),
                    HorizontalSpace(WidthManager.w8),
                    Icon(Icons.more_vert_sharp),
                  ],
                ),
              ],
            ),
          ),

          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: EdgeInsets.only(top: PaddingManager.ph4),
              color: Colors.red,
              width: double.infinity,
              height: HeightsManager.h173,
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(
              left: PaddingManager.pw8,
              right: PaddingManager.pw8,
              top: PaddingManager.ph12,
              bottom: PaddingManager.ph5,
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                margin: EdgeInsets.only(top: PaddingManager.ph4),
                color: Colors.red,
                width: double.infinity,
                height: HeightsManager.h41,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleAnimal extends StatelessWidget {
  const _TitleAnimal({
    required this.onPressedAddNewAnimal,
    required this.count,
  });

  final VoidCallback onPressedAddNewAnimal;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: PaddingManager.pw6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${ConstsValuesManager.animals} ( $count )",
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

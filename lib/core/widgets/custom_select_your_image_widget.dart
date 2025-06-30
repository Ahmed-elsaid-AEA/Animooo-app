import 'dart:io';

import 'package:animooo/core/enums/select_image_status.dart';
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
  const CustomSelectImageWidget({
    super.key,
    this.file,
    required this.onTapAtSelectImage,
    required this.selectImageStatus,
  });

  final File? file;
  final SelectImageStatus selectImageStatus;
  final GestureTapCallback onTapAtSelectImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapAtSelectImage,
      child: file == null
          ? NotFoundImage(selectImageStatus: selectImageStatus)
          : FoundImage(file: file!, selectImageStatus: selectImageStatus),
    );
  }
}

class FoundImage extends StatelessWidget {
  const FoundImage({
    super.key,
    required this.file,
    required this.selectImageStatus,
  });

  final File file;
  final SelectImageStatus selectImageStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          // padding: EdgeInsets.symmetric(
          //   vertical: PaddingManager.ph4,
          //   horizontal: PaddingManager.pw4,
          // ),
          radius: Radius.circular(BorderRadiusManager.br10),
          color: selectImageStatus == SelectImageStatus.normal
              ? ColorManager.kPrimaryColor
              : selectImageStatus == SelectImageStatus.noImageSelected
              ? ColorManager.kRedColor
              : ColorManager.kGreenColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(BorderRadiusManager.br10),
          child: SizedBox(
            width: double.infinity,
            child: Image.file(file),
          ),
        ),
      ),
    );
  }
}

class NotFoundImage extends StatelessWidget {
  const NotFoundImage({super.key, required this.selectImageStatus});

  final SelectImageStatus selectImageStatus;

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
          color: selectImageStatus == SelectImageStatus.normal
              ? ColorManager.kPrimaryColor
              : selectImageStatus == SelectImageStatus.noImageSelected
              ? ColorManager.kRedColor
              : ColorManager.kGreenColor,
        ),
        child: SizedBox(
          height: HeightsManager.h100,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: selectImageStatus == SelectImageStatus.normal
                    ? ColorManager.kPrimaryColor
                    : selectImageStatus == SelectImageStatus.noImageSelected
                    ? ColorManager.kRedColor
                    : ColorManager.kGreenColor,
                size: FontSizeManager.s28,
              ),
              VerticalSpace(HeightsManager.h16),
              Text(
                ConstsValuesManager.selectYourImage,
                style: TextStyle(
                  color: selectImageStatus == SelectImageStatus.normal
                      ? ColorManager.kPrimaryColor
                      : selectImageStatus == SelectImageStatus.noImageSelected
                      ? ColorManager.kRedColor
                      : ColorManager.kGreenColor,
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

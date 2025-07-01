import 'package:animooo/core/enums/button_status_enum.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/assets_values_manager.dart';
import '../../resources/border_radius_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/fonts_size_manager.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.height,
    this.textColor,
    this.fontSize,
    this.borderRadius,
    this.buttonStatus,
  });

  final String text;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? fontSize;
  final BorderRadius? borderRadius;
  final ButtonStatusEnum? buttonStatus;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          buttonStatus == ButtonStatusEnum.loading ||
              buttonStatus == ButtonStatusEnum.disabled
          ? null
          : onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height ?? HeightsManager.h44),

        backgroundColor: backgroundColor ?? ColorManager.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? BorderRadius.circular(BorderRadiusManager.br5),
        ),
      ),
      child: buttonStatus == ButtonStatusEnum.loading
          ? Center(
              child: CupertinoActivityIndicator(
                color: ColorManager.kPrimaryColor,
              ),
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor ?? ColorManager.kWhiteColor,
                fontFamily: FontsManager.poppinsFontFamily,
                fontSize: fontSize ?? FontSizeManager.s14,
              ),
            ),
    );
  }
}

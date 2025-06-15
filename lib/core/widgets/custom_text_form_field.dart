import 'package:flutter/material.dart';

import '../resources/border_radius_manager.dart';
import '../resources/colors_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.borderRadius,
    this.suffix,
  });

  final String? hintText;
  final double? borderRadius;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.kLightWhiteColor,
        hintText: hintText,
        suffix: suffix,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? BorderRadiusManager.br10,
          ),
          borderSide: BorderSide(color: ColorManager.kLightGreyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? BorderRadiusManager.br10,
          ),
          borderSide: BorderSide(color: ColorManager.kPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? BorderRadiusManager.br10,
          ),
          borderSide: BorderSide(color: ColorManager.kRedColor),
        ),
      ),
    );
  }
}

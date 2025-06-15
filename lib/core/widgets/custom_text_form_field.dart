import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:flutter/material.dart';

import '../resources/border_radius_manager.dart';
import '../resources/colors_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.borderRadius,
    this.suffixIcon,
    this.obscureText = false,
  });

  final String? hintText;
  final double? borderRadius;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: '*',
      obscureText: obscureText,
      style: TextStyle(
        color: ColorManager.kPrimaryColor,
        fontSize: FontSizeManager.s14,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorManager.kLightWhiteColor,
        hintText: hintText,
        hintStyle: TextStyle(color: ColorManager.kGrey2Color),
        suffixIcon: Padding(
          padding: EdgeInsetsGeometry.zero,
          child: suffixIcon,
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 0),
        isDense: true,

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

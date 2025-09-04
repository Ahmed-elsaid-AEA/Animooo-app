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
    this.validator,
    required this.keyboardType,
    this.controller,
    this.fillColor,
    this.textAlign,
    this.focusNode,
    this.onChanged,
    this.useDefaultErrorBuilder = true,
    this.maxLines = 1,
  });

  final String? hintText;
  final double? borderRadius;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final Color? fillColor;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final bool useDefaultErrorBuilder;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: HeightsManager.h44,
      child: TextFormField(
        maxLines: maxLines,
        errorBuilder: useDefaultErrorBuilder == true
            ? null
            : (context, errorText) => SizedBox(),
        focusNode: focusNode,
        textAlign: textAlign ?? TextAlign.start,
        controller: controller,
        obscuringCharacter: '*',
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: ColorManager.kPrimaryColor,
          fontSize: FontSizeManager.s14,
        ),
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? ColorManager.kLightWhiteColor,
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? BorderRadiusManager.br10,
            ),
            borderSide: BorderSide(color: ColorManager.kLightGreyColor),
          ),
          // focusedErrorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(
          //     widget.borderRadius ?? BorderRadiusManager.br10,
          //   ),
          //   borderSide: BorderSide(color: ColorManager.kBoldRedColor),
          // ),
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
      ),
    );
  }
}

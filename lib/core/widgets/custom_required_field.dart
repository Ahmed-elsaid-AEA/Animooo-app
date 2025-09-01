import 'package:flutter/cupertino.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class CustomRequiredField extends StatelessWidget {
  const CustomRequiredField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.validator,
    this.onChanged,
    required this.keyboardType,
    this.maxLines,
  });

  final String hintText;
  final TextEditingController controller;
  final String title;
  final TextInputType keyboardType;
  final int? maxLines;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorManager.kGreyColor,
              fontFamily: FontsManager.poppinsFontFamily,
            ),
          ),
        ),
        VerticalSpace(HeightsManager.h6),
        CustomTextFormField(
          maxLines: maxLines,
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,

          hintText: hintText,
        ),
      ],
    );
  }
}

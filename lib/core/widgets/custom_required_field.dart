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
  });

  final String hintText;
  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validator;

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
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          validator: validator,
          hintText: hintText,
        ),
      ],
    );
  }
}

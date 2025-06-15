import 'package:flutter/cupertino.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class LastNameFieldSignUpPage extends StatelessWidget {
  const LastNameFieldSignUpPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ConstsValuesManager.lastName,
            style: TextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorManager.kGreyColor,
              fontFamily: FontsManager.poppinsFontFamily,
            ),
          ),
        ),
        VerticalSpace(height: HeightsManager.h6),
        CustomTextFormField(
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return ConstsValuesManager.enterYourEmailAddress;
            }
            //TODO:: add email validation
            else {
              return null;
            }
          },
          hintText: ConstsValuesManager.enterYourEmailAddress,
        ),
        VerticalSpace(height: HeightsManager.h16),
      ],
    );
  }
}

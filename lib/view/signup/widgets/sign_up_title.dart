import 'package:flutter/material.dart';

import '../../../../core/resources/assets_values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/conts_values.dart';
import '../../../../core/resources/fonts_size_manager.dart';

class TitleSignUpPage extends StatelessWidget {
  const TitleSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      ConstsValuesManager.signUp,
      style: TextStyle(
        fontFamily: FontsManager.otamaEpFontFamily,
        fontSize: FontSizeManager.s38_21,
        color: ColorManager.kBlackColor,
      ),
    );
  }
}

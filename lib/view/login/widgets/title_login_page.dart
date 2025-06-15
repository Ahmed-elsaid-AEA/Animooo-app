import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';

class TitleLoginPage extends StatelessWidget {
  const TitleLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      ConstsValuesManager.login,
      style: TextStyle(
        fontFamily: FontsManager.otamaEpFontFamily,
        fontSize: FontSizeManager.s38_21,
        color: ColorManager.kBlackColor,
      ),
    );
  }
}

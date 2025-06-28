import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class RequiredRulesForPasswordSignUpPage extends StatelessWidget {
  const RequiredRulesForPasswordSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (ConstsListsManager.passwordRulesRequirements.any(
          (element) => element['valid'] == false,
        ))
          TitleRules(),
        VerticalSpace(HeightsManager.h5),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            bool isValid =
                ConstsListsManager.passwordRulesRequirements[index][ConstsValuesManager.valid];
            return RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: Icon(Icons.circle, size: 5.sp),
                  ),
                  WidgetSpan(child: HorizontalSpace(WidthManager.w2)),
                  TextSpan(
                    text: ConstsListsManager
                        .passwordRulesRequirements[index][ConstsValuesManager.title],
                    style: TextStyle(
                      color: isValid == true
                          ? ColorManager.kGreenColor
                          : ColorManager.kRedColor,
                      fontSize: FontSizeManager.s9,
                      fontFamily: FontsManager.poppinsFontFamily,
                      fontWeight: FontWeight.w700,
                      decoration: isValid == true
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: HeightsManager.h5);
          },
          itemCount: ConstsListsManager.passwordRulesRequirements.length,
        ),
        VerticalSpace(HeightsManager.h16),
      ],
    );
  }
}

class TitleRules extends StatelessWidget {
  const TitleRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      ConstsValuesManager.passwordAddAllNecessaryCharactersToCreateSafePassword,
      style: TextStyle(
        color: ColorManager.kRedColor,
        fontSize: FontSizeManager.s10,
        fontFamily: FontsManager.poppinsFontFamily,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

import '../../resources/colors_manager.dart';
import '../../resources/width_manager.dart';
import '../custom_text_form_field.dart';
import '../spacing/horizontal_space.dart';

class AppOtpVerificationTextField extends StatefulWidget {
  const AppOtpVerificationTextField({super.key, required this.onCompleted});

  final void Function(String value) onCompleted;

  @override
  State<AppOtpVerificationTextField> createState() =>
      _AppOtpVerificationTextFieldState();
}

class _AppOtpVerificationTextFieldState
    extends State<AppOtpVerificationTextField> {
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;
  late TextEditingController controller5;
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();

    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    controller5 = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(focusNode1);
    });
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();

    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    super.dispose();
  }

  void goToNextFocusNode(
    String value,
    FocusNode focusNode,
    TextEditingController controller,
  ) {
    if (value.trim().isNotEmpty) {
      if (value.length > 1) {
        controller.text = value[value.length - 1];
      }
      FocusScope.of(context).requestFocus(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            onChanged: (value) {
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(focusNode1);
              } else {
                goToNextFocusNode(value, focusNode2, controller1);
              }
            },
            controller: controller1,
            focusNode: focusNode1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w18),
        Expanded(
          child: CustomTextFormField(
            onChanged: (value) {
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(focusNode1);
              }
              goToNextFocusNode(value, focusNode3, controller2);
            },
            controller: controller2,
            focusNode: focusNode2,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w18),
        Expanded(
          child: CustomTextFormField(
            focusNode: focusNode3,
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(focusNode2);
              }
              goToNextFocusNode(value, focusNode4, controller3);
            },
            controller: controller3,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w18),
        Expanded(
          child: CustomTextFormField(
            focusNode: focusNode4,
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(focusNode3);
              }
              goToNextFocusNode(value, focusNode5, controller4);
            },
            controller: controller4,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w18),
        Expanded(
          child: CustomTextFormField(
            onChanged: (value) {
              if (value.trim().isNotEmpty) {
                if (value.length > 1) {
                  controller5.text = value[value.length - 1];
                }
                FocusScope.of(context).unfocus();
                widget.onCompleted(
                  controller1.text.trim() +
                      controller2.text.trim() +
                      controller3.text.trim() +
                      controller4.text.trim() +
                      controller5.text.trim(),
                );
              }
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(focusNode4);
              }
            },
            focusNode: focusNode5,
            controller: controller5,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            fillColor: ColorManager.kWhiteColor,
          ),
        ),
      ],
    );
  }
}

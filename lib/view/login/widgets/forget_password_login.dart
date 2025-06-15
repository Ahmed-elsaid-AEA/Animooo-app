import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:flutter/material.dart';

class ForgetPasswordLogin extends StatelessWidget {
  const ForgetPasswordLogin({
    super.key,
    required this.onPressedAtForgetPassword,
  });

  final void Function() onPressedAtForgetPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -10,
            right: 0,
            child: TextButton(
              onPressed: onPressedAtForgetPassword,
              child: Text(
                ConstsValuesManager.forgotPassword,
                style: TextStyle(
                  color: ColorManager.kPrimaryColor,
                  fontSize: FontSizeManager.s10,
                  decoration: TextDecoration.underline,
                  fontFamily: FontsManager.poppinsFontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

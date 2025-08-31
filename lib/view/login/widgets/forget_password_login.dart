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
    required this.onChangedRememberMe,
    required this.rememberMeOutPutStream,
  });

  final void Function() onPressedAtForgetPassword;
  final void Function(bool? value) onChangedRememberMe;
  final Stream<bool> rememberMeOutPutStream;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HeightsManager.h61,
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
          Positioned(
            top: -10,
            left: 0,

            child: SizedBox(
              width: MediaQuery.of(context).size.width * .5,

              child: StreamBuilder<bool>(
                initialData: true,
                stream: rememberMeOutPutStream,
                builder: (context, snapshot) => CheckboxListTile(
                  value: snapshot.data ?? true,
                  onChanged: onChangedRememberMe,
                  title: Text(
                    ConstsValuesManager.rememberMe,
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
            ),
          ),
        ],
      ),
    );
  }
}

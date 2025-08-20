import 'package:animooo/controller/create_new_password_controller.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/widgets/app_Bar/simple_app_bar.dart';
import 'package:animooo/core/widgets/buttons/app_button.dart';
import 'package:animooo/view/create_new_password/screens/widgets/create_new_password_form.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/widgets/custom_required_password_field.dart';
import '../../../core/widgets/loading/app_model_progress_hud.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../../signup/widgets/required_rules_for_password_sign_up_page.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  late CreateNewPasswordController _createNewPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createNewPasswordController = CreateNewPasswordController(context);
  }

  @override
  void dispose() {
    _createNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _createNewPasswordController.getArguments();
    return Scaffold(
      appBar: SimpleAppBar(title: ConstsValuesManager.cancel),
      body: AppModelProgressHud(
        loadingOutputStream:
            _createNewPasswordController.loadingScreenOutPutStream,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: PaddingManager.pw18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpace(HeightsManager.h9_15),
                  Text(
                    ConstsValuesManager.createNewPassword,
                    style: TextStyle(
                      fontFamily: FontsManager.otamaEpFontFamily,
                      fontSize: FontSizeManager.s20,
                      color: ColorManager.kPrimaryColor,
                    ),
                  ),
                  VerticalSpace(HeightsManager.h10),
                  CreateNewPasswordForm(
                    onChanged: _createNewPasswordController.onChangedTextField,
                    newPasswordController:
                        _createNewPasswordController.newPasswordController,
                    confirmPasswordController:
                        _createNewPasswordController.confirmPasswordController,
                    onPressedAtEyeNewPassword:
                        _createNewPasswordController.onPressedAtEyeNewPassword,
                    onPressedAtEyeConfirmPassword: _createNewPasswordController
                        .onPressedAtEyeConfirmPassword,
                    visibleNewPasswordOutputStream: _createNewPasswordController
                        .visibleNewPasswordOutPutStream,
                    visibleConfirmPasswordOutputStream:
                        _createNewPasswordController
                            .visibleConfirmPasswordOutPutStream,
                    formKey: _createNewPasswordController.formKey,
                  ),
                  AppButton(
                    text: ConstsValuesManager.submit,
                    onTap: _createNewPasswordController.onTapAtSubmitButton,
                    buttonStatusOutputStream:
                        _createNewPasswordController.submitButtonOutPutStream,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

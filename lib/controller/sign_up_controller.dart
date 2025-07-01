import 'dart:async';
import 'dart:io';

import 'package:animooo/core/enums/button_status_enum.dart';
import 'package:animooo/core/enums/select_image_status.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/functions/image_picker_service.dart';
import 'package:animooo/core/functions/show_select_image_model_bottom_sheet.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/extenstions.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/buttons/app_button.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:animooo/data/network/auth_api.dart';
import 'package:animooo/models/auth/auth_response.dart';
import 'package:animooo/models/auth/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/enums/screen_status_state.dart';

class SignUpController {
  File? fileImage;
  SelectImageStatus selectImageStatus = SelectImageStatus.normal;
  ButtonStatusEnum signUpButtonStatus = ButtonStatusEnum.disabled;
  ScreensStatusState screenState = ScreensStatusState.initial;

  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;

  bool visibleConfirmPassword = false;
  bool visiblePassword = false;
  late Stream<File?> fileImageOutPutStream;
  late Sink<File?> fileImageInput;
  late StreamController<File?> fileImageController;

  late Stream<bool> visiblePasswordOutPutStream;
  late Sink<bool> visiblePasswordInput;
  late StreamController<bool> visiblePasswordController;

  //?confirm password

  late Stream<bool> visibleConfirmPasswordOutPutStream;
  late Sink<bool> visibleConfirmPasswordInput;
  late StreamController<bool> visibleConfirmPasswordController;

  void initState() {
    //?init controllers
    initControllers();
    //?init streams
    initStreams();
  }

  void dispose() {
    //?dispose streams
    disposeStreams();
    //?dispose controllers
    disposeControllers();
  }

  void initControllers() async {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();

    firstNameController.text = "Ahmed";
    lastNameController.text = "Mohamed";
    emailController.text = "ahmed122727727@gmail.com";
    passwordController.text = "123!@#QWEqwweewwe";
    confirmPasswordController.text = "123!@#QWEqwweewwe";
    phoneController.text = "01001398831";
  }

  void initStreams() {
    //?init stream of file image
    fileImageController = StreamController<File?>();
    fileImageOutPutStream = fileImageController.stream;
    fileImageInput = fileImageController.sink;
    //?init stream of visible password
    visiblePasswordController = StreamController<bool>();
    visiblePasswordOutPutStream = visiblePasswordController.stream;
    visiblePasswordInput = visiblePasswordController.sink;
    //?init stream of visible confirm password
    visibleConfirmPasswordController = StreamController<bool>();
    visibleConfirmPasswordOutPutStream =
        visibleConfirmPasswordController.stream;
    visibleConfirmPasswordInput = visibleConfirmPasswordController.sink;
  }

  void disposeStreams() {
    //?dispose stream of file image
    fileImageInput.close();
    fileImageController.close();
    //?dispose stream of visible password
    visiblePasswordInput.close();
    visiblePasswordController.close();
    //?dispose stream of visible confirm password
    visibleConfirmPasswordInput.close();
    visibleConfirmPasswordController.close();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
  }

  SignUpController() {
    initState();
  }

  void _changeRule(int index, bool value) {
    ConstsListsManager.passwordRulesRequirements[index][ConstsValuesManager
            .valid] =
        value;
  }

  void onChangePassword(String value) {
    passwordController.text = passwordController.getText;
    //?check value is less than 12
    if (value.trim().length < 12) {
      _changeRule(0, false);
    } else {
      _changeRule(0, true);
    }
    //?check value contains at least one uppercase letter
    if (!value.trim().contains(RegExp(r"[A-Z]"))) {
      _changeRule(1, false);
    } else {
      _changeRule(1, true);
    }
    //?check value contains at least one lowercase letter
    if (!value.trim().contains(RegExp(r"[a-z]"))) {
      _changeRule(2, false);
    } else {
      _changeRule(2, true);
    }
    //?check value contains at least one special character
    if (!value.trim().contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _changeRule(3, false);
    } else {
      _changeRule(3, true);
    }
    //?check value contains at least one number
    if (!value.trim().contains(RegExp(r"[0-9]"))) {
      _changeRule(4, false);
    } else {
      _changeRule(4, true);
    }
  }

  Future<void> onTapAtSelectImage(BuildContext context) async {
    //?chow model bottom sheet
    await showSelectImageModelBottomSheet(
      context,
      () {
        _onTapAtCamera(context);
      },
      () {
        _onTapAtGallery(context);
      },
    );

    //?check if image is selected
    if (fileImage == null) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    } else {
      selectImageStatus = SelectImageStatus.imageSelected;
      checkValidate();
    }
  }

  Future<void> onTapSignUp() async {
    //?check if image is selected
    if (selectImageStatus == SelectImageStatus.normal) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    }
    if (formKey.currentState!.validate() &&
        selectImageStatus == SelectImageStatus.imageSelected) {
      //? 1 - show loading
      screenState = ScreensStatusState.loading;
      //? update ui
      //? setState(() {});
      //? request api
      Either<FailureModel, AuthResponse> response = await AuthApi.signUp(
        UserModel(
          firstName: firstNameController.getText,
          lastName: lastNameController.getText,
          email: emailController.getText,
          password: passwordController.getText,
          phone: phoneController.getText,
          image: fileImage!,
        ),
      );
      response.fold(
        (FailureModel l) {
          //TODO:: show error
          //?show snackbar
        },
        (AuthResponse r) {
          //?go to verify email
          //TODO:: go to verify email
        },
      );
    }
  }

  void checkValidate() {
    //?check if image is selected
    if (selectImageStatus == SelectImageStatus.normal) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    }
    if (formKey.currentState!.validate() &&
        selectImageStatus == SelectImageStatus.imageSelected) {
      //? make api
      signUpButtonStatus = ButtonStatusEnum.enabled;
    } else {
      signUpButtonStatus = ButtonStatusEnum.disabled;
    }
  }

  void onPressedAtEyePassword() {
    visiblePassword = !visiblePassword;
    visiblePasswordInput.add(visiblePassword);
  }

  void onPressedAtEyeConfirmPassword() {
    visibleConfirmPassword = !visibleConfirmPassword;
    visibleConfirmPasswordInput.add(visibleConfirmPassword);
  }

  void _onTapAtCamera(context) async {
    fileImage = await ImagePickerService.pickImage(ImageSource.camera);
    fileImageInput.add(fileImage);
    Navigator.pop(context);
  }

  void _onTapAtGallery(BuildContext context) async {
    fileImage = await ImagePickerService.pickImage(ImageSource.gallery);
    fileImageInput.add(fileImage);
    Navigator.pop(context);
  }
}

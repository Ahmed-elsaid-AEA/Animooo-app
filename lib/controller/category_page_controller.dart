import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/enums/button_status_enum.dart';
import '../core/enums/screen_status_state.dart';
import '../core/enums/select_image_status.dart';
import '../core/functions/image_picker_service.dart';
import '../core/functions/show_select_image_model_bottom_sheet.dart';

class CategoryPageController {
  //?category image
  File? fileImage;

  //?save button status
  ButtonStatusEnum saveButtonStatus = ButtonStatusEnum.disabled;

  //?screen state
  ScreensStatusState screenState = ScreensStatusState.initial;

  //?category select image status
  SelectImageStatus selectImageStatus = SelectImageStatus.normal;

  //?category form key
  final GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();

  //?category name controller
  late TextEditingController categoryNameController;

  //?category description controller
  late TextEditingController categoryDescriptionController;

  //?streams
  //?category image stream
  late Stream<File?> categoryFileImageOutPutStream;
  late Sink<File?> categoryFileImageInput;
  late StreamController<File?> categoryFileImageController;

  //? save button status stream
  late Stream<ButtonStatusEnum?> saveButtonStatusOutPutStream;
  late Sink<ButtonStatusEnum?> saveButtonStatusInput;
  late StreamController<ButtonStatusEnum?> saveButtonStatusController;

  //?stream of loading screen state
  late Stream<bool> loadingScreenStateOutPutStream;
  late Sink<bool> loadingScreenStateInput;
  late StreamController<bool> loadingScreenStateController;
  final BuildContext context;
  static CategoryPageController? _instance;

  CategoryPageController._internal(this.context) {
    //?
    print("TestHomeController");
    init();
  }

  factory CategoryPageController(BuildContext context) {
    return _instance ??= CategoryPageController._internal(context);
  }

  // CategoryPageController(this.context) {
  //   print("init category page controller");
  //   init();
  // }

  void changeSaveButtonStatus(ButtonStatusEnum status) {
    saveButtonStatus = status;
    saveButtonStatusInput.add(status);
  }

  void init() {
    //?init controllers
    initControllers();
    //?init streams
    initStreams();
    //?change save button status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeSaveButtonStatus(ButtonStatusEnum.disabled);
    });
  }

  void initControllers() {
    //?init controller of text editing
    categoryNameController = TextEditingController();
    categoryDescriptionController = TextEditingController();
  }

  void initStreams() {
    //?init category image stream
    categoryFileImageController = StreamController<File?>();
    categoryFileImageOutPutStream = categoryFileImageController.stream
        .asBroadcastStream();
    categoryFileImageInput = categoryFileImageController.sink;
    //?init save button status stream
    saveButtonStatusController = StreamController<ButtonStatusEnum?>();
    saveButtonStatusOutPutStream = saveButtonStatusController.stream
        .asBroadcastStream();
    saveButtonStatusInput = saveButtonStatusController.sink;
    //?init loading screen state stream
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateOutPutStream = loadingScreenStateController.stream
        .asBroadcastStream();
    loadingScreenStateInput = loadingScreenStateController.sink;
  }

  void dispose() {
    //?dispose controllers
    disposeControllers();
    //?dispose streams
    disposeStreams();
  }

  void disposeControllers() {
    //?dispose controller of text editing
    categoryNameController.dispose();
    categoryDescriptionController.dispose();
  }

  void disposeStreams() {}

  void onChanged(String value) {
    checkValidateForm();
  }

  void checkValidateForm() {
    if (categoryFormKey.currentState!.validate()) {
      changeSaveButtonStatus(ButtonStatusEnum.enabled);
    } else {
      changeSaveButtonStatus(ButtonStatusEnum.disabled);
    }
  }

  void onTapAtSelectImage(FormFieldState<File> state) async {
    //?chow model bottom sheet
    await showSelectImageModelBottomSheet(
      context,
      _onTapAtCamera,
      _onTapAtGallery,
    );

    //?check if image is selected
    if (fileImage == null) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    } else {
      selectImageStatus = SelectImageStatus.imageSelected;
      state.didChange(fileImage);
      checkValidateForm();
    }
  }

  void _onTapAtCamera() async {
    fileImage = await ImagePickerService.pickImage(ImageSource.camera);
    categoryFileImageInput.add(fileImage);

    if (context.mounted) Navigator.pop(context);
  }

  void _onTapAtGallery() async {
    fileImage = await ImagePickerService.pickImage(ImageSource.gallery);
    categoryFileImageInput.add(fileImage);
    if (context.mounted) Navigator.pop(context);
  }
}

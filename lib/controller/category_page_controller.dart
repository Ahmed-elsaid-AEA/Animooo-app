import 'dart:async';
import 'dart:io';

import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/data/network/category_api.dart';
import 'package:animooo/models/category_model.dart';
import 'package:animooo/models/category_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/enums/button_status_enum.dart';
import '../core/enums/screen_status_state.dart';
import '../core/enums/select_image_status.dart';
import '../core/functions/app_scaffold_massanger.dart';
import '../core/functions/image_picker_service.dart';
import '../core/functions/show_select_image_model_bottom_sheet.dart';
import '../core/resources/conts_values.dart';

class CategoryPageController {
  //?category image
  File? categoryFileImage;

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
    print("CategoryPageController");
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
    if (categoryFileImage == null) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    } else {
      selectImageStatus = SelectImageStatus.imageSelected;
      state.didChange(categoryFileImage);
      checkValidateForm();
    }
  }

  void _onTapAtCamera() async {
    categoryFileImage = await ImagePickerService.pickImage(ImageSource.camera);
    categoryFileImageInput.add(categoryFileImage);

    if (context.mounted) Navigator.pop(context);
  }

  void _onTapAtGallery() async {
    categoryFileImage = await ImagePickerService.pickImage(ImageSource.gallery);
    categoryFileImageInput.add(categoryFileImage);
    if (context.mounted) Navigator.pop(context);
  }

  void onTapSaveButton() async {
    if (categoryFormKey.currentState!.validate()) {
      InternetCheckerService isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?make api
        await _requestCreateNewCategory();
      } else {
        if (context.mounted) {
          showAppSnackBar(context, ConstsValuesManager.noInternetConnection);
        }
      }
    }
  }

  Future<void> _requestCreateNewCategory() async {
    //loading
    changeScreenStateLoading(ScreensStatusState.loading);
    changeSaveButtonStatus(ButtonStatusEnum.loading);
    Either<FailureModel, CategoryResponse> result =
        await CategoryApi.createNewCategory(
          CategoryModel(
            name: categoryNameController.text,
            description: categoryDescriptionController.text,
            image: categoryFileImage!,
          ),
        );
    result.fold(
      (l) {
        _onFailureCreateNewCategory(l);
      },
      (r) {
        _onSuccessCreateNewCategory(r);
      },
    );
    changeSaveButtonStatus(ButtonStatusEnum.enabled);
  }

  void _onSuccessCreateNewCategory(CategoryResponse r) {
    changeScreenStateLoading(ScreensStatusState.success);
    showAppSnackBar(context, r.message);
  }

  void _onFailureCreateNewCategory(FailureModel l) {
    changeScreenStateLoading(ScreensStatusState.failure);
    String message = _filterErrors(l.errors);
    showAppSnackBar(
      context,
      message,
      onPressedAtRetry: () {
        onTapSaveButton();
      },
    );
  }

  void changeScreenStateLoading(ScreensStatusState state) {
    loadingScreenStateInput.add(state == ScreensStatusState.loading);
  }

  String _filterErrors(List<String> errors) {
    List<String> errorsList = [];
    errors = errors.map((e) => e.toLowerCase().trim()).toList();
    void makeFilter(String contain, String msgError) {
      if (errors.join("").contains(contain.toLowerCase())) {
        errorsList.add(msgError);
      }
    }

    if (errors.isNotEmpty) {
      makeFilter("Token is required", ConstsValuesManager.tokenIsRequired);
      makeFilter("image is required", ConstsValuesManager.imageIsRequired);
      makeFilter(
        "category name is required",
        ConstsValuesManager.categoryNameIsRequired,
      );
      makeFilter(
        "category description is required",
        ConstsValuesManager.categoryDescriptionIsRequired,
      );
      makeFilter("Token is required", ConstsValuesManager.tokenIsRequired);
      makeFilter(
        "Invalid or expired token",
        ConstsValuesManager.invalidOrExpiredToken,
      );
      makeFilter(
        "Category should be unique",
        ConstsValuesManager.categoryShouldBeUnique,
      );
    }

    return errorsList.join(" , ");
  }
}

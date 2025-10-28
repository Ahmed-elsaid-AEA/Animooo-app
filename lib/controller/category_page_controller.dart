import 'dart:async';
import 'dart:io';

import 'package:animooo/controller/home_page_controller.dart';
import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/widgets/custom_select_your_image_widget.dart';
import 'package:animooo/data/network/category_api.dart';
import 'package:animooo/models/gategory/category_model.dart';
import 'package:animooo/models/gategory/category_response.dart';
import 'package:animooo/view/main_page/screen/main_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/enums/widget_status_enum.dart';
import '../core/enums/screen_status_state.dart';
import '../core/enums/select_image_status.dart';
import '../core/functions/app_scaffold_massanger.dart';
import '../core/functions/image_picker_service.dart';
import '../core/functions/show_select_image_model_bottom_sheet.dart';
import '../core/resources/conts_values.dart';

class CategoryPageController {
  bool isEdit = false;
  bool isDeleteNow = false;


  CategoryInfoModel? categoryInfoModel;

  //?category image
  File? categoryFileImage;

  //?save button status
  WidgetStatusEnum saveButtonStatus = WidgetStatusEnum.disabled;

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
  late Stream<WidgetStatusEnum?> saveButtonStatusOutPutStream;
  late Sink<WidgetStatusEnum?> saveButtonStatusInput;
  late StreamController<WidgetStatusEnum?> saveButtonStatusController;

  //?stream of loading screen state
  late Stream<bool> loadingScreenStateOutPutStream;
  late Sink<bool> loadingScreenStateInput;
  late StreamController<bool> loadingScreenStateController;
  final BuildContext context;
  static CategoryPageController? _instance;
  //?save and edit button text stream
  late Stream<String> saveAndEditButtonTextOutPutStream;
  late Sink<String> saveAndEditButtonTextInput;
  late StreamController<String> saveAndEditButtonTextController;

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

  void changeSaveButtonStatus(WidgetStatusEnum status) {
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
      changeSaveButtonStatus(WidgetStatusEnum.disabled);
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
    saveButtonStatusController = StreamController<WidgetStatusEnum?>();
    saveButtonStatusOutPutStream = saveButtonStatusController.stream
        .asBroadcastStream();
    saveButtonStatusInput = saveButtonStatusController.sink;
    //?init loading screen state stream
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateOutPutStream = loadingScreenStateController.stream
        .asBroadcastStream();
    loadingScreenStateInput = loadingScreenStateController.sink;
    //?init save and edit button text stream
    saveAndEditButtonTextController = StreamController<String>();
    saveAndEditButtonTextOutPutStream = saveAndEditButtonTextController.stream
        .asBroadcastStream();
    saveAndEditButtonTextInput = saveAndEditButtonTextController.sink;
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

  void disposeStreams() {
    //?dispose stream of category image
    categoryFileImageController.close();
    categoryFileImageInput.close();
    //?dispose stream of save button status
    saveButtonStatusController.close();
    saveButtonStatusInput.close();
    //?dispose stream of loading screen state
    loadingScreenStateController.close();
    loadingScreenStateInput.close();
    //?dispose stream of save and edit button text
    saveAndEditButtonTextController.close();
    saveAndEditButtonTextInput.close();
  }

  void onChanged(String value) {
    checkValidateForm();
  }

  void checkValidateForm() {
    if (categoryFormKey.currentState!.validate()) {
      changeSaveButtonStatus(WidgetStatusEnum.enabled);
    } else {
      changeSaveButtonStatus(WidgetStatusEnum.disabled);
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

  void onTapSaveAndUpdateButton() async {
    if (categoryFormKey.currentState!.validate()) {
      InternetCheckerService isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?make api
        if (isEdit == true) {
          //request update
          await _inUpdateMethod();
        } else {
          await _requestCreateNewCategory();
        }
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
    changeSaveButtonStatus(WidgetStatusEnum.loading);
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
    changeSaveButtonStatus(WidgetStatusEnum.enabled);
  }

  void _onSuccessCreateNewCategory(CategoryResponse r) {
    changeScreenStateLoading(ScreensStatusState.success);
    categoryInfoModel = r.category;
    showAppSnackBar(context, r.message);
    _goToHomeTap();
  }

  void clearForm() {
    categoryNameController.clear();
    categoryDescriptionController.clear();
    categoryFileImageInput.add(null);
    changeSaveButtonStatus(WidgetStatusEnum.disabled);
    categoryInfoModel = null;
    isEdit = false;
    isDeleteNow = false;
    _changeSaveAndEditButtonText();
  }

  void _onFailureCreateNewCategory(FailureModel l) {
    changeScreenStateLoading(ScreensStatusState.failure);
    String message = _filterErrors(l.errors);
    showAppSnackBar(
      context,
      message,
      onPressedAtRetry: () {
        onTapSaveAndUpdateButton();
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

  void _goToHomeTap() {
    HomePageController homePageController = HomePageController();
    if (isDeleteNow == true) {
      print("delete");
      homePageController.listCategories.removeWhere(
        (element) => element.id == categoryInfoModel!.id,
      );
    } else if (isEdit == false) {
      homePageController.listCategories.add(categoryInfoModel!);
    } else {
      //update case
      int index = homePageController.listCategories.indexWhere(
        (cat) => cat.id == categoryInfoModel!.id,
      );
      homePageController.listCategories.removeWhere(
        (element) => element.id == categoryInfoModel!.id,
      );
      homePageController.listCategories.insert(index, categoryInfoModel!);
    }
    mainPageKey.currentState?.mainPageController.onTapBottomNavigationBarItem(
      0,
    );
    homePageController.updateListCategories();
  }

  void fillForm() {
    if (categoryInfoModel != null) {
      categoryNameController.text = categoryInfoModel!.name;
      categoryDescriptionController.text = categoryInfoModel!.description;
      categoryFileImage = File(categoryInfoModel!.imagePath);
      categoryImgKey.currentState?.updateState(categoryFileImage!);
      _updateCategoryFileImage();
      _changeSaveAndEditButtonText();
      changeSaveButtonStatus(WidgetStatusEnum.enabled);
    }
  }

  void _changeSaveAndEditButtonText() {
    saveAndEditButtonTextInput.add(
      isEdit == true ? ConstsValuesManager.update : ConstsValuesManager.save,
    );
  }

  void _updateCategoryFileImage() {
    categoryFileImageInput.add(categoryFileImage);
  }

  Future<void> _requestUpdateCategory() async {
    //loading
    changeScreenStateLoading(ScreensStatusState.loading);
    changeSaveButtonStatus(WidgetStatusEnum.loading);
    Either<FailureModel, CategoryResponse> result =
        await CategoryApi.updateCategory(
          CategoryModel(
            name: categoryNameController.text,
            description: categoryDescriptionController.text,
            image: categoryFileImage!,
          ),
          categoryInfoModel!.id.toString(),
        );
    result.fold(
      (l) {
        print(l);
        _onFailureCreateNewCategory(l);
      },
      (r) {
        _onSuccessCreateNewCategory(r);
      },
    );
    changeSaveButtonStatus(WidgetStatusEnum.enabled);
  }

  Future<void> _inUpdateMethod() async {
    if (categoryInfoModel!.name != categoryNameController.text ||
        categoryInfoModel!.description != categoryDescriptionController.text ||
        categoryInfoModel!.imagePath != categoryFileImage!.path) {
      await _requestUpdateCategory();
    } else {
      showAppSnackBar(context, ConstsValuesManager.noChanges);
    }
  }

  void onTapDeleteButton() {
    isDeleteNow = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(ApiConstants.delete),
        content: const Text(ApiConstants.areYouSureYouWantToDeleteThisCategory),
        actions: [
          TextButton(
            child: const Text(ConstsValuesManager.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text(ApiConstants.delete),
            onPressed: () {
              _requestDeleteCategory();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _requestDeleteCategory() async {
    Navigator.pop(context);
    //loading
    changeScreenStateLoading(ScreensStatusState.loading);
    changeSaveButtonStatus(WidgetStatusEnum.loading);
    Either<FailureModel, String> result = await CategoryApi.deleteCategory(
      categoryInfoModel!.id.toString(),
    );
    result.fold(
      (l) {
        print(l);
        _onFailureCreateNewCategory(l);
      },
      (r) {
        _onSuccessDeleteNewCategory(r);
      },
    );
    changeSaveButtonStatus(WidgetStatusEnum.enabled);
  }

  _onSuccessDeleteNewCategory(String r) {
    changeScreenStateLoading(ScreensStatusState.success);
    showAppSnackBar(context, r);
    _goToHomeTap();
  }
}

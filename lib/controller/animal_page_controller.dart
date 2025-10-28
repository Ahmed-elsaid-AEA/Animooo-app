import 'dart:async';
import 'dart:io';

import 'package:animooo/core/widgets/custom_select_your_image_widget.dart';
import 'package:animooo/data/network/animal_api.dart';
import 'package:animooo/models/animal/animal_model.dart';
import 'package:animooo/models/animal/animal_response_model.dart';
import 'package:animooo/models/gategory/category_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/enums/screen_status_state.dart';
import '../core/enums/select_image_status.dart';
import '../core/enums/widget_status_enum.dart';
import '../core/error/failure_model.dart';
import '../core/functions/app_scaffold_massanger.dart';
import '../core/functions/image_picker_service.dart';
import '../core/functions/show_select_image_model_bottom_sheet.dart';
import '../core/resources/conts_values.dart';
import '../view/main_page/screen/main_page.dart';
import 'home_page_controller.dart';

class AnimalPageController {
  //?animal image
  AnimalResponseModel? animalResponseModel;
  File? animalFileImage;
  bool isEdit = false;
  bool isDeleteNow = false;
  BuildContext context;

  static AnimalPageController? _instance;
  List<CategoryInfoModel> listCategory = [];

  AnimalPageController._internal(this.context) {
    print("animal page controller");
    init();
  }

  factory AnimalPageController(BuildContext context) {
    return _instance ??= AnimalPageController._internal(context);
  }

  //?screen state
  ScreensStatusState screenState = ScreensStatusState.initial;

  //?stream of loading screen state
  late Stream<bool> loadingScreenStateOutPutStream;
  late Sink<bool> loadingScreenStateInput;
  late StreamController<bool> loadingScreenStateController;

  //?category select image status
  SelectImageStatus selectImageStatus = SelectImageStatus.normal;

  //?save button status
  WidgetStatusEnum saveButtonStatus = WidgetStatusEnum.disabled;

  //?stream of save button status
  late Stream<WidgetStatusEnum?> saveButtonStatusOutPutStream;
  late Sink<WidgetStatusEnum?> _saveButtonStatusInput;
  late StreamController<WidgetStatusEnum?> _saveButtonStatusController;

  //?streams
  //?animal image stream
  late Stream<File?> animalFileImageOutPutStream;
  late Sink<File?> animalFileImageInput;
  late StreamController<File?> animalFileImageController;

  //?selected index category stream
  late Stream<int?> selectedIndexCategoryOutPutStream;
  late Sink<int?> selectedIndexCategoryInput;
  late StreamController<int?> selectedIndexCategoryController;

  //?animal form key
  final GlobalKey<FormState> animalFormKey = GlobalKey<FormState>();

  //?animal name controller
  late TextEditingController animalNameController;

  //?animal description controller
  late TextEditingController animalDescriptionController;

  //?animal price controller
  late TextEditingController animalPriceController;

  //?list category stream
  late Stream<List<CategoryInfoModel>> listCategoryOutPutStream;
  late Sink<List<CategoryInfoModel>> listCategoryInput;
  late StreamController<List<CategoryInfoModel>> listCategoryController;

  //?save and edit button text stream
  late Stream<String> saveAndEditButtonTextOutPutStream;
  late Sink<String> saveAndEditButtonTextInput;
  late StreamController<String> saveAndEditButtonTextController;

  int? selectedIndexCategory;

  void init() {
    _initStreams();
    _initControllers();
    _changeButtonStatus(WidgetStatusEnum.disabled);
  }

  void _changeButtonStatus(WidgetStatusEnum statue) {
    _saveButtonStatusInput.add(statue);
  }

  void _initStreams() {
    //?init loading screen state stream
    loadingScreenStateController = StreamController<bool>();
    loadingScreenStateOutPutStream = loadingScreenStateController.stream;
    loadingScreenStateInput = loadingScreenStateController.sink;
    //?init animal image stream
    animalFileImageController = StreamController<File?>();
    animalFileImageOutPutStream = animalFileImageController.stream;
    animalFileImageInput = animalFileImageController.sink;
    //?init list category stream
    listCategoryController = StreamController<List<CategoryInfoModel>>();
    listCategoryOutPutStream = listCategoryController.stream;
    listCategoryInput = listCategoryController.sink;
    //?init save and edit button text stream
    saveAndEditButtonTextController = StreamController<String>();
    saveAndEditButtonTextOutPutStream = saveAndEditButtonTextController.stream;
    saveAndEditButtonTextInput = saveAndEditButtonTextController.sink;
    //?init save button status stream
    _saveButtonStatusController = StreamController<WidgetStatusEnum>();
    saveButtonStatusOutPutStream = _saveButtonStatusController.stream;
    _saveButtonStatusInput = _saveButtonStatusController.sink;
    //?init selected index category stream
    selectedIndexCategoryController = StreamController<int?>();
    selectedIndexCategoryOutPutStream = selectedIndexCategoryController.stream;
    selectedIndexCategoryInput = selectedIndexCategoryController.sink;
  }

  void _initControllers() {
    //?init controller of text editing
    animalNameController = TextEditingController();
    animalDescriptionController = TextEditingController();
    animalPriceController = TextEditingController();
  }

  void _disposeControllers() {
    //?dispose controller of text editing
    //?dispose name controllers
    animalNameController.dispose();
    //?dispose description controllers
    animalDescriptionController.dispose();
    //?dispose price controllers
    animalPriceController.dispose();
  }

  void _disposeStreams() {
    //?loading screen dispose
    loadingScreenStateController.close();
    loadingScreenStateInput.close();
    //?animal image dispose
    animalFileImageController.close();
    animalFileImageInput.close();
    //?list category dispose
    listCategoryController.close();
    listCategoryInput.close();
    //?save and edit button text dispose
    saveAndEditButtonTextController.close();
    saveAndEditButtonTextInput.close();
    //?save button status dispose
    _saveButtonStatusController.close();
    _saveButtonStatusInput.close();
    //?selected index category dispose
    selectedIndexCategoryController.close();
    selectedIndexCategoryInput.close();
  }

  void dispose() {
    _disposeStreams();
    _disposeFormKey();
    _disposeControllers();
  }

  void _disposeFormKey() {
    animalFormKey.currentState?.dispose();
  }

  void onSelectedCategory(int index) {
    selectedIndexCategory = index;
    checkValidateForm();
    _updateSelectedIndexCategory();
  }

  _updateSelectedIndexCategory() {
    selectedIndexCategoryInput.add(selectedIndexCategory);
  }

  void updateListCategory() {
    listCategoryInput.add(listCategory);
  }

  void checkValidateForm() {
    if (animalFormKey.currentState!.validate() &&
        animalFileImage != null &&
        selectedIndexCategory != null) {
      changeSaveButtonStatus(WidgetStatusEnum.enabled);
    } else {
      changeSaveButtonStatus(WidgetStatusEnum.disabled);
    }
  }

  void _onTapAtCamera() async {
    animalFileImage = await ImagePickerService.pickImage(ImageSource.camera);
    _updateAnimalImage();

    if (context.mounted) Navigator.pop(context);
  }

  void _updateAnimalImage() {
    animalFileImageInput.add(animalFileImage);
  }

  void _onTapAtGallery() async {
    animalFileImage = await ImagePickerService.pickImage(ImageSource.gallery);
    _updateAnimalImage();
    if (context.mounted) Navigator.pop(context);
  }

  void onTapAtSelectImage(FormFieldState<File> state) async {
    //?chow model bottom sheet
    await showSelectImageModelBottomSheet(
      context,
      _onTapAtCamera,
      _onTapAtGallery,
    );

    //?check if image is selected
    if (animalFileImage == null) {
      selectImageStatus = SelectImageStatus.noImageSelected;
    } else {
      selectImageStatus = SelectImageStatus.imageSelected;
      state.didChange(animalFileImage);
      checkValidateForm();
    }
  }

  void onChanged(String value) {
    checkValidateForm();
  }

  void onTapSaveAndUpdateButton() async {
    if (animalFormKey.currentState!.validate() &&
        animalFileImage != null &&
        selectedIndexCategory != null) {
      InternetCheckerService isInternetConnected = InternetCheckerService();
      bool result = await isInternetConnected();
      if (result == true) {
        //?make api
        if (isEdit == true) {
          //request update
          // await _inUpdateMethod();
        } else {
          await _requestCreateNewAnimal();
        }
      } else {
        if (context.mounted) {
          showAppSnackBar(context, ConstsValuesManager.noInternetConnection);
        }
      }
    } else {
      showAppSnackBar(context, ConstsValuesManager.pleaseFillAllFields);
    }
  }

  _changeScreenStateLoading(ScreensStatusState state) {
    screenState = state;
    loadingScreenStateInput.add(screenState == ScreensStatusState.loading);
  }

  void changeSaveButtonStatus(WidgetStatusEnum status) {
    saveButtonStatus = status;
    _saveButtonStatusInput.add(status);
  }

  Future<void> _requestCreateNewAnimal() async {
    //loading
    _changeScreenStateLoading(ScreensStatusState.loading);
    changeSaveButtonStatus(WidgetStatusEnum.loading);
    AnimalModel animalModel = AnimalModel(
      name: animalNameController.text,
      description: animalDescriptionController.text,
      image: animalFileImage!,
      categoryId: listCategory[selectedIndexCategory!].id,
      //?change that
      price: double.tryParse(animalPriceController.text) ?? 0,
    );
    Either<FailureModel, AnimalResponseModel> result =
        await AnimalApi.createNewAnimal(animalModel);
    result.fold(
      (l) {
        _onFailureCreateNewAnimal(l);
      },
      (r) {
        _onSuccessCreateNewAnimal(r);
      },
    );
    changeSaveButtonStatus(WidgetStatusEnum.enabled);
  }

  void _onFailureCreateNewAnimal(FailureModel l) {
    _changeScreenStateLoading(ScreensStatusState.failure);
    String message = _filterErrors(l.errors);
    showAppSnackBar(
      context,
      message,
      onPressedAtRetry: () {
        onTapSaveAndUpdateButton();
      },
    );
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
      makeFilter(
        "Animal should be unique",
        ConstsValuesManager.animalShouldBeUnique,
      );
      makeFilter("Token is required", ConstsValuesManager.tokenIsRequired);
      makeFilter("image is required", ConstsValuesManager.imageIsRequired);
      makeFilter(
        "This category not found",
        ConstsValuesManager.thisCategoryNotFound,
      );
      makeFilter(
        "animal description is required",
        ConstsValuesManager.categoryDescriptionIsRequired,
      );
      makeFilter(
        "Invalid or expired token",
        ConstsValuesManager.invalidOrExpiredToken,
      );
    }

    return errorsList.join(" , ");
  }

  void _onSuccessCreateNewAnimal(AnimalResponseModel r) {
    _changeScreenStateLoading(ScreensStatusState.success);
    animalResponseModel = r;
    showAppSnackBar(context, r.message);
    _goToHomeTap();
  }

  void _goToHomeTap() {
    HomePageController homePageController = HomePageController();
    if (isDeleteNow == true) {
      // print("delete");
      // homePageController.listCategories.removeWhere(
      //       (element) => element.id == categoryInfoModel!.id,
      // );
    } else if (isEdit == false) {
      homePageController.listAnimal.add(animalResponseModel!.animal);
    } else {
      //update case
      // int index = homePageController.listCategories.indexWhere(
      //       (cat) => cat.id == categoryInfoModel!.id,
      // );
      // homePageController.listCategories.removeWhere(
      //       (element) => element.id == categoryInfoModel!.id,
      // );
      // homePageController.listCategories.insert(index, categoryInfoModel!);
    }
    mainPageKey.currentState?.mainPageController.onTapBottomNavigationBarItem(
      0,
    );
    homePageController.updateListAnimal();
  }

  void clearForm() {
    animalNameController.clear();
    animalDescriptionController.clear();
    animalPriceController.clear();
    animalFileImage = null;
    _updateAnimalImage();
    selectedIndexCategory = null;
    _updateSelectedIndexCategory();
    changeSaveButtonStatus(WidgetStatusEnum.disabled);
  }
}

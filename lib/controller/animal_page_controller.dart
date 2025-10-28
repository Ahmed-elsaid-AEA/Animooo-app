import 'dart:async';
import 'dart:io';

import 'package:animooo/data/network/animal_api.dart';
import 'package:animooo/models/animal/animal_model.dart';
import 'package:animooo/models/gategory/category_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/di/services/internet_checker_service.dart';
import '../core/enums/screen_status_state.dart';
import '../core/enums/select_image_status.dart';
import '../core/enums/widget_status_enum.dart';
import '../core/error/failure_model.dart';
import '../core/functions/app_scaffold_massanger.dart';
import '../core/resources/conts_values.dart';

class AnimalPageController {
  //?animal image
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
  late Sink<WidgetStatusEnum?> saveButtonStatusInput;
  late StreamController<WidgetStatusEnum?> saveButtonStatusController;

  //?streams
  //?animal image stream
  late Stream<File?> animalFileImageOutPutStream;
  late Sink<File?> animalFileImageInput;
  late StreamController<File?> animalFileImageController;

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
    saveButtonStatusController = StreamController<WidgetStatusEnum>();
    saveButtonStatusOutPutStream = saveButtonStatusController.stream;
    saveButtonStatusInput = saveButtonStatusController.sink;
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
    saveButtonStatusController.close();
    saveButtonStatusInput.close();
  }

  void dispose() {
    _disposeStreams();
    _disposeFormKey();
    _disposeControllers();
  }

  void _disposeFormKey() {
    animalFormKey.currentState?.dispose();
  }

  void onSelectedCategory(int index) {}

  void updateListCategory() {
    listCategoryInput.add(listCategory);
  }

  void onTapSaveAndUpdateButton() async {
    await _requestCreateNewAnimal();

    // if (animalFormKey.currentState!.validate()) {
    //   InternetCheckerService isInternetConnected = InternetCheckerService();
    //   bool result = await isInternetConnected();
    //   if (result == true) {
    //     //?make api
    //     if (isEdit == true) {
    //       //request update
    //       // await _inUpdateMethod();
    //     } else {
    //       await _requestCreateNewAnimal();
    //     }
    //   } else {
    //     if (context.mounted) {
    //       showAppSnackBar(context, ConstsValuesManager.noInternetConnection);
    //     }
    //   }
    // }
  }

  _changeScreenStateLoading(ScreensStatusState state) {
    screenState = state;
    loadingScreenStateInput.add(screenState == ScreensStatusState.loading);
  }
  void changeSaveButtonStatus(WidgetStatusEnum status) {
    saveButtonStatus = status;
    saveButtonStatusInput.add(status);
  }
  Future<void> _requestCreateNewAnimal() async {
    //loading
    _changeScreenStateLoading(ScreensStatusState.loading);
    changeSaveButtonStatus(WidgetStatusEnum.loading);
    Either<FailureModel, CategoryResponse> result =
        await AnimalApi.createNewAnimal(
          AnimalModel(
            name: animalNameController.text,
            description: animalDescriptionController.text,
            image: File("path"),
            categoryId: 1,//?change that
            price: double.tryParse(animalPriceController.text) ?? 0,
          ),
        );
    result.fold(
      (l) {
        //This category not found
        // "Animal should be unique"
        // _onFailureCreateNewCategory(l);
      },
      (r) {
        // _onSuccessCreateNewCategory(r);
      },
    );
    changeSaveButtonStatus(WidgetStatusEnum.enabled);
  }
}

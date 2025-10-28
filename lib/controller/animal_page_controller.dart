import 'dart:async';
import 'dart:io';

import 'package:animooo/models/gategory/category_response.dart';
import 'package:flutter/material.dart';

import '../core/enums/screen_status_state.dart';
import '../core/enums/select_image_status.dart';

class AnimalPageController {
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
}

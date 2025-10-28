import 'dart:async';

import 'package:animooo/controller/category_page_controller.dart';
import 'package:animooo/controller/main_page_controller.dart';
import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/enums/widget_status_enum.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/functions/app_navigations.dart';
import 'package:animooo/core/functions/show_edit_or_delete_item_bottom_sheet.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/routes_manager.dart';
import 'package:animooo/data/network/animal_api.dart';
import 'package:animooo/data/network/category_api.dart';
import 'package:animooo/models/animal/animal_response_model.dart';
import 'package:animooo/models/gategory/categories_model_response.dart';
import 'package:animooo/models/gategory/category_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/main_page/screen/main_page.dart';

class HomePageController {
  static HomePageController? _instance;

  HomePageController._internal() {
    //?
    print("HomePageController");
    init();
    getAllCategories();
    getAllAnimal();
  }

  factory HomePageController() {
    return _instance ??= HomePageController._internal();
  }

  //? list categories
  List<CategoryInfoModel> listCategories = [];

  //? list animal
  List<AnimalInfoResponseModel> listAnimal = [];

  //? stream list categories
  late Stream<List<CategoryInfoModel>> listCategoriesOutput;
  late StreamController<List<CategoryInfoModel>> listCategoriesController;
  late Sink<List<CategoryInfoModel>> listCategoriesInput;

  //? stream list animal
  late Stream<List<AnimalInfoResponseModel>> listAnimalOutput;
  late StreamController<List<AnimalInfoResponseModel>> listAnimalController;
  late Sink<List<AnimalInfoResponseModel>> listAnimalInput;
  WidgetStatusEnum listCategoriesStatus = WidgetStatusEnum.enabled;
  WidgetStatusEnum listAnimalStatus = WidgetStatusEnum.enabled;

  //? stream section categories status
  late Sink<WidgetStatusEnum> sectionCategoriesStatusInput;
  late Stream<WidgetStatusEnum> sectionCategoriesStatusOutput;
  late StreamController<WidgetStatusEnum> sectionCategoriesStatusController;

  //? stream section animal status
  late Sink<WidgetStatusEnum> sectionAnimalStatusInput;
  late Stream<WidgetStatusEnum> sectionAnimalStatusOutput;
  late StreamController<WidgetStatusEnum> sectionAnimalStatusController;

  void init() {
    _initStreams();
  }

  void _initStreams() {
    listCategoriesController = StreamController<List<CategoryInfoModel>>();
    listCategoriesInput = listCategoriesController.sink;
    listCategoriesOutput = listCategoriesController.stream.asBroadcastStream();
    //?init stream of list categories status
    sectionCategoriesStatusController = StreamController<WidgetStatusEnum>();
    sectionCategoriesStatusInput = sectionCategoriesStatusController.sink;
    sectionCategoriesStatusOutput = sectionCategoriesStatusController.stream
        .asBroadcastStream();
    //?init stream of list animal
    listAnimalController = StreamController<List<AnimalInfoResponseModel>>();
    listAnimalInput = listAnimalController.sink;
    listAnimalOutput = listAnimalController.stream.asBroadcastStream();
    //?init stream of list animal status
    sectionAnimalStatusController = StreamController<WidgetStatusEnum>();
    sectionAnimalStatusInput = sectionAnimalStatusController.sink;
    sectionAnimalStatusOutput = sectionAnimalStatusController.stream
        .asBroadcastStream();
  }

  void _disposeStreams() {
    listCategoriesController.close();
    listCategoriesInput.close();
    //?dispose stream of list categories status
    sectionCategoriesStatusController.close();
    sectionCategoriesStatusInput.close();
    //?dispose stream of list animal
    listAnimalController.close();
    listAnimalInput.close();
    //?dispose stream of list animal status
    sectionAnimalStatusController.close();
    sectionAnimalStatusInput.close();
  }

  void dispose() {
    _disposeStreams();
  }

  void onPressedAtSeeMore(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = getIt<GlobalKey<NavigatorState>>(
      instanceName: ConstsValuesManager.homePageNavigationState,
    );
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState?.pushNamed(
        RoutesName.categoryPageDetails.route,
      );
    } else {
      AppNavigation.pushNamed(context, RoutesName.categoryPageDetails);
    }
  }

  void goToCategoryTapPage() {
    // MainPageController mainPageController = MainPageController(context);
    // mainPageController.onTapBottomNavigationBarItem(2);
    mainPageKey.currentState?.mainPageController.onTapBottomNavigationBarItem(
      2,
    );
  }

  void goToAnimalTapPage() {
    mainPageKey.currentState?.mainPageController.onTapBottomNavigationBarItem(
      3,
    );
  }

  Future<void> getAllCategories() async {
    _updateListCategoriesStatus(WidgetStatusEnum.loading);
    var result = await CategoryApi.getAllCategoriesRequest();
    result.fold(
      (l) => _onFailureRequestAllCategories(l),
      (r) => _onSuccessRequestAllCategories(r),
    );
    _updateListCategoriesStatus(WidgetStatusEnum.enabled);
  }

  Future<void> getAllAnimal() async {
    _updateListAnimalStatus(WidgetStatusEnum.loading);
    var result = await AnimalApi.getAllAnimalRequest();
    result.fold(
      (l) => _onFailureRequestAllAnimal(l),
      (r) => _onSuccessRequestAllAnimal(r),
    );
    _updateListAnimalStatus(WidgetStatusEnum.enabled);
  }

  void _updateListAnimalStatus(WidgetStatusEnum widgetStatusEnum) {
    listAnimalStatus = widgetStatusEnum;
    sectionAnimalStatusInput.add(listAnimalStatus);
  }

  void _updateListCategoriesStatus(WidgetStatusEnum widgetStatusEnum) {
    listCategoriesStatus = widgetStatusEnum;
    sectionCategoriesStatusInput.add(listCategoriesStatus);
  }

  void _onFailureRequestAllCategories(FailureModel failureModel) {}

  void _onSuccessRequestAllCategories(
    CategoriesModelResponse categoriesModelResponse,
  ) {
    listCategories = categoriesModelResponse.categories;
    updateListCategories();
  }

  void _onSuccessRequestAllAnimal(List<AnimalInfoResponseModel> r) {
    listAnimal = r;
    updateListAnimal();
  }

  void updateListAnimal() {
    listAnimalInput.add(listAnimal);
  }

  void updateListCategories() {
    listCategoriesInput.add(listCategories);
  }

  Future<void> onRefresh() async {
    listCategories.clear();
    listAnimal.clear();
    updateListCategories();
    updateListAnimal();
    getAllCategories();
    getAllAnimal();
  }

  void onTapAtCategory(CategoryInfoModel category, BuildContext context) async {
    goToCategoryTapPage();
    await Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        CategoryPageController categoryPageController = CategoryPageController(
          context,
        );
        categoryPageController.categoryInfoModel = category;
        categoryPageController.isEdit = true;
        categoryPageController.fillForm();
      }
    });
  }

  void _onFailureRequestAllAnimal(FailureModel l) {}

  void onTapAtMoreOfAnimal(
    AnimalInfoResponseModel animalModel,
    BuildContext context,
  ) {
    showEditOrDeleteItemBottomSheet(
      context: context,
      onTapEdit: () => onTapEditItemAnimal(context),
      onTapAtDelete: () =>
          onTapAtDeleteItemAnimal(context, animalModel.animalId),
    );
  }

  void onTapAtDeleteItemAnimal(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Animal'),
        content: const Text('Are you sure you want to delete this animal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _requestDeleteAnimal(context, id),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _requestDeleteAnimal(BuildContext context, int id) async {
    AppNavigation.pop(context);
    print(id);

    _updateListCategoriesStatus(WidgetStatusEnum.loading);
    var result = await AnimalApi.deleteAnimal(id);
    result.fold(
      (l) => _onFailureRequestDeleteAnimal(l),
      (r) {

        _onSuccessRequestDeleteAnimal(r, id);
      },
    );
    _updateListCategoriesStatus(WidgetStatusEnum.enabled);
  }

  void onTapEditItemAnimal(BuildContext context) {}

  void _onFailureRequestDeleteAnimal(FailureModel l) {
    print(l);
  }

  void _onSuccessRequestDeleteAnimal(String r, int id) {

    listAnimal.removeWhere((element) => element.animalId == id);
    updateListAnimal();

  }
}

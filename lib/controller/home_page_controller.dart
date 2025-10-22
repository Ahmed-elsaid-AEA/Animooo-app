import 'dart:async';

import 'package:animooo/controller/category_page_controller.dart';
import 'package:animooo/controller/main_page_controller.dart';
import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/di/get_it.dart';
import 'package:animooo/core/enums/widget_status_enum.dart';
import 'package:animooo/core/error/failure_model.dart';
import 'package:animooo/core/functions/app_navigations.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/routes_manager.dart';
import 'package:animooo/data/network/category_api.dart';
import 'package:animooo/models/gategory/categories_model_response.dart';
import 'package:animooo/models/gategory/category_response.dart';
import 'package:flutter/cupertino.dart';

import '../view/main_page/screen/main_page.dart';

class HomePageController {
  static HomePageController? _instance;

  HomePageController._internal() {
    //?
    print("HomePageController");
    init();
    getAllCategories();
  }

  factory HomePageController() {
    return _instance ??= HomePageController._internal();
  }

  late Stream<List<CategoryInfoModel>> listCategoriesOutput;
  late StreamController<List<CategoryInfoModel>> listCategoriesController;
  List<CategoryInfoModel> listCategories = [];
  late Sink<List<CategoryInfoModel>> listCategoriesInput;
  WidgetStatusEnum listCategoriesStatus = WidgetStatusEnum.enabled;
  late Sink<WidgetStatusEnum> sectionCategoriesStatusInput;
  late Stream<WidgetStatusEnum> sectionCategoriesStatusOutput;
  late StreamController<WidgetStatusEnum> sectionCategoriesStatusController;

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
  }

  void _disposeStreams() {
    listCategoriesController.close();
    listCategoriesInput.close();
    //?dispose stream of list categories status
    sectionCategoriesStatusController.close();
    sectionCategoriesStatusInput.close();
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

  void updateListCategories() {
    listCategoriesInput.add(listCategories);
  }

  Future<void> onRefresh() async {
    listCategories.clear();
    updateListCategories();
    await getAllCategories();
  }

  void onTapAtCategory(CategoryInfoModel category, BuildContext context) {
    goToCategoryTapPage();
    CategoryPageController categoryPageController = CategoryPageController(
      context,
    );
    categoryPageController.categoryInfoModel = category;
    categoryPageController.isEdit = true;
    categoryPageController.fillForm();
  }
}

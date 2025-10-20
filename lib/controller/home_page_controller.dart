import 'dart:async';

import 'package:animooo/controller/main_page_controller.dart';
import 'package:animooo/core/database/api/dio_service.dart';
import 'package:animooo/core/di/get_it.dart';
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

  void init() {
    _initStreams();
  }

  void _initStreams() {
    listCategoriesController = StreamController<List<CategoryInfoModel>>();
    listCategoriesInput = listCategoriesController.sink;
    listCategoriesOutput = listCategoriesController.stream;
  }

  void _disposeStreams() {
    listCategoriesController.close();
    listCategoriesInput.close();
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

  void getAllCategories() async {
    var result = await CategoryApi.getAllCategoriesRequest();
    result.fold(
          (l) => _onFailureRequestAllCategories(l),
          (r) => _onSuccessRequestAllCategories(r),
    );
  }

  void _onFailureRequestAllCategories(FailureModel failureModel) {}

  void _onSuccessRequestAllCategories(
      CategoriesModelResponse categoriesModelResponse,) {
    listCategories = categoriesModelResponse.categories;
    updateListCategories();
  }

  void updateListCategories() {
    listCategoriesInput.add(listCategories);
  }
}

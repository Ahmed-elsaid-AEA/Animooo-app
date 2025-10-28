import 'dart:async';

import 'package:animooo/controller/animal_page_controller.dart';
import 'package:animooo/controller/category_page_controller.dart';
import 'package:animooo/controller/home_page_controller.dart';
import 'package:animooo/view/main_page/animal_page/animal_page.dart';
import 'package:animooo/view/main_page/home/screen/home_tab.dart';
import 'package:flutter/material.dart';

import '../core/di/get_it.dart';
import '../core/resources/conts_values.dart';
import '../view/main_page/category/screen/category_page.dart';

class MainPageController {
  bool isAnimatedByUser = false;
  BuildContext context;

  int _currentIndex = 0;

  //?streams
  //?bottom navigation bar stream
  late StreamController<int> currentIndexStreamController;

  late Stream<int> currentIndexOutputStream;
  late Sink<int> currentIndexInput;

  List<Widget?> pages = List.filled(5, null);
  List<bool> hasVisited = List.filled(5, false);
  CategoryPageController? categoryPageController;
  HomePageController? homePageController;
  AnimalPageController? animalPageController;

  //?page controller
  late final PageController pageController;

  Widget buildWidget(int index) {
    if (!hasVisited[index]) {
      debugPrint("building page$index");
      hasVisited[index] = true;
      switch (index) {
        case 0:
          //?build controller
          homePageController ??= HomePageController();
          pages[index] = HomeTab();
          break;
        case 1:
          // categoryPageController ??= CategoryPageController(context);
          pages[index] = Scaffold(body: Center(child: Text("Search")));
        case 2:
          categoryPageController ??= CategoryPageController(context);
          pages[index] = CategoryPage();

        case 3:
          animalPageController ??= AnimalPageController(context);
          pages[index] = AnimalPage();
        case 4:
          // categoryPageController ??= CategoryPageController(context);
          pages[index] = Scaffold(body: Center(child: Text("Me")));
          break;
      }
    }
    return pages[index]!;
  }

  //?constructor
  MainPageController(this.context) {
    //?init
    init();
  }

  void init() {
    //?init bottom
    initStreams();
    //?init page controller
    pageController = PageController(initialPage: _currentIndex);
  }

  void initStreams() {
    //?init bottom navigation bar stream
    currentIndexStreamController = StreamController<int>.broadcast();
    currentIndexOutputStream = currentIndexStreamController.stream;
    currentIndexInput = currentIndexStreamController.sink;
  }

  void dispose() {
    //?dispose streams
    disposeStreams();
    //!dispose other controllers dispose method
    //?dispose category page controller dispose method
    categoryPageController?.dispose();
    //?dispose animal page controller dispose method
    animalPageController?.dispose();
    //?dispose home page controller dispose method
    homePageController?.dispose();
  }

  void disposeStreams() {
    currentIndexStreamController.close();
    currentIndexInput.close();
  }

  void changeCurrentIndex(int value) {
    _currentIndex = value;
    currentIndexInput.add(value);
  }

  void onPageChangedOfPageView(int value) {
    if (isAnimatedByUser == false) {
      changeCurrentIndex(value);
    }
  }

  void onTapBottomNavigationBarItem(int value) async {
    isAnimatedByUser = true;
    if (_currentIndex == 2) {
      //come from category page
      categoryPageController?.clearForm();
    }
    changeCurrentIndex(value);
    //after change current index
    if (_currentIndex == 3) {
      AnimalPageController animalPageController = AnimalPageController(context);
      animalPageController.listCategory = homePageController!.listCategories;
      animalPageController.updateListCategory();
    }
    await pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    isAnimatedByUser = false;
    if (_currentIndex == 0) {
      getIt<GlobalKey<NavigatorState>>(
        instanceName: ConstsValuesManager.homePageNavigationState,
      ).currentState?.popUntil((route) => route.isFirst);
    }
  }
}
//TODO :: show image selected widget in animal page
import 'dart:async';

import 'package:animooo/view/main_page/home/screen/home_page.dart';
import 'package:flutter/material.dart';

import '../view/main_page/category/screen/category_page.dart';

class MainPageController {
  int _currentIndex = 0;

  //?streams
  //?bottom navigation bar stream
  late StreamController<int> currentIndexStreamController;

  late Stream<int> currentIndexOutputStream;
  late Sink<int> currentIndexInput;

  List<Widget> pages = [
    HomePage(),
    Scaffold(body: Center(child: Text('search'))),
    CategoryPage(),
    Scaffold(body: Center(child: Text('Animals'))),
    Scaffold(body: Center(child: Text('Me'))),
  ];

  //?constructor
  MainPageController() {
    //?init
    init();
  }

  void init() {
    //?init bottom
    initStreams();
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
  }

  void disposeStreams() {
    currentIndexStreamController.close();
    currentIndexInput.close();
  }

  void onTapBottomNavigationBarItem(int value) {
    _currentIndex = value;
    currentIndexInput.add(value);
  }
}

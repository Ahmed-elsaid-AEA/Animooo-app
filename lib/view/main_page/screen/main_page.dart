import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/app_logo_widget.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:animooo/view/main_page/widgets/home_page_animals.dart';
import 'package:animooo/view/main_page/widgets/home_page_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../widgets/home_page_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomePageAppBar(),
              VerticalSpace(HeightsManager.h18),
              HomePageCategories(
                onPressedAddNewCategory: () {},
                onPressedAtSeeMore: () {},
              ),
              HomePageAnimals(
                onPressedAddNewCategory: () {},
                onPressedAtSeeMore: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        backgroundColor: ColorManager.kWhite2Color,
        selectedItemColor: ColorManager.kPrimaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: FontSizeManager.s12,
          fontWeight: FontWeight.w500,
          color: ColorManager.kPrimaryColor,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: FontSizeManager.s12,
          fontWeight: FontWeight.w500,
          color: ColorManager.kGrey6Color,
        ),
        unselectedItemColor: ColorManager.kGrey6Color,
        items: [
          BottomNavigationBarItem(
            backgroundColor: ColorManager.kWhite2Color,
            icon: Icon(Icons.home),
            label: ConstsValuesManager.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: ConstsValuesManager.category,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_fill),
            label: ConstsValuesManager.animal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ConstsValuesManager.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ConstsValuesManager.me,
          ),
        ],
      ),
    );
  }
}

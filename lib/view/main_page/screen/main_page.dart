import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/app_logo_widget.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:animooo/view/main_page/widgets/home_page_animals.dart';
import 'package:animooo/view/main_page/widgets/home_page_categories.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../widgets/home_page_app_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
    );
  }
}

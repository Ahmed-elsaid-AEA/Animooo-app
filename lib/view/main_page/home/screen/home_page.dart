import 'package:flutter/material.dart';

import '../../../../core/resources/heights_manager.dart';
import '../../../../core/widgets/spacing/vertical_space.dart';
import '../../widgets/home_page_animals.dart';
import '../../widgets/home_page_app_bar.dart';
import '../../widgets/home_page_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}

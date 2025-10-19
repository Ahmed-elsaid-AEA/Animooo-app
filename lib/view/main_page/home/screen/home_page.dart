import 'package:animooo/view/main_page/screen/main_page.dart';
import 'package:flutter/material.dart';

import '../../../../controller/home_page_controller.dart';
import '../../../../core/resources/heights_manager.dart';
import '../../../../core/widgets/spacing/vertical_space.dart';
import '../../widgets/home_page_animals.dart';
import '../../widgets/home_page_app_bar.dart';
import '../../widgets/home_page_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController _homePageController;

  @override
  void initState() {
    super.initState();
    _homePageController = HomePageController();
  }

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
              onPressedAddNewCategory: () {
                _homePageController.goToCategoryTapPage(context);
              },
              onPressedAtSeeMore: () {
                _homePageController.onPressedAtSeeMore(context);
              },
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

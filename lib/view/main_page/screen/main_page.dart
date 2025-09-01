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

import '../../../controller/main_page_controller.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/widgets/spacing/vertical_space.dart';
import '../widgets/home_page_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  late MainPageController _mainPageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainPageController = MainPageController(context);
  }

  @override
  void dispose() {
    _mainPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _mainPageController.currentIndexOutputStream,
      initialData: 0,
      builder: (context, snapshot) => Scaffold(
        body: PageView(
          onPageChanged: (value) {
            _mainPageController.onTapBottomNavigationBarItem(value);
          },
          controller: _mainPageController.pageController,
          children: [
            for (int i = 0; i < _mainPageController.pages.length; i++)
              _mainPageController.hasVisited[i]
                  ? _mainPageController.buildWidget(i)
                  : (snapshot.data == i
                        ? _mainPageController.buildWidget(i)
                        : Container()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            _mainPageController.onTapBottomNavigationBarItem(value);
            _mainPageController.pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          currentIndex: snapshot.data ?? 0,
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
              icon: Icon(Icons.search),
              label: ConstsValuesManager.search,
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
              icon: Icon(Icons.person),
              label: ConstsValuesManager.me,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

//TODO: add AutomaticKeepAliveClientMixin to all pages ( me , animal ,search)

import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controller/main_page_controller.dart';

final GlobalKey<_MainPageState> mainPageKey = GlobalKey<_MainPageState>();

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: mainPageKey);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  late MainPageController mainPageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainPageController = MainPageController(context);
  }

  @override
  void dispose() {
    mainPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<int>(
      stream: mainPageController.currentIndexOutputStream,
      initialData: 0,
      builder: (context, snapshot) => Scaffold(
        body: PageView(
          onPageChanged: mainPageController.onPageChangedOfPageView,
          controller: mainPageController.pageController,
          children: [
            for (int i = 0; i < mainPageController.pages.length; i++)
              mainPageController.hasVisited[i]
                  ? mainPageController.buildWidget(i)
                  : (snapshot.data == i
                        ? mainPageController.buildWidget(i)
                        : Container()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: mainPageController.onTapBottomNavigationBarItem,
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

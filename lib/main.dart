import 'package:animooo/core/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/animooo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  getItSetup();
  runApp(const AnimoooApp());
}

class TestMainPage extends StatefulWidget {
  const TestMainPage({super.key});

  @override
  State<TestMainPage> createState() => _TestMainPageState();
}

class _TestMainPageState extends State<TestMainPage> {
  int _currentIndex = 0;
  List<Widget?> pages = List.filled(2, null);
  List<bool> _hasVisted = List.filled(2, false);
  TestHomeController? _testHomeController;
  TestSearchController? _testSearchController;

  Widget _buildWidget(int index) {
    if (!_hasVisted[index]) {
      print("building page$index");
      _hasVisted[index] = true;
      switch (index) {
        case 0:
          //?build controller
          _testHomeController ??= TestHomeController();
          pages[index] = TestHomePage();
          break;
        case 1:
          _testSearchController ??= TestSearchController();
          pages[index] = TestSearchPage();
          break;
      }
    }
    return pages[index]!;
  }

  @override
  void dispose() {
    // _testSearchController?.dispose();
    // _testHomeController?.dispose();
    super.dispose();
  }

  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value){
          setState(() {
            _currentIndex = value;
          });
        },
        controller: _pageController,
        children: [
          for (int i = 0; i < pages.length; i++)
            _hasVisted[i]
                ? _buildWidget(i)
                : (_currentIndex == i ? _buildWidget(i) : Container()),
        ],
      ),
      // body: Stack(
      //   children: [
      //     for (int i = 0; i < pages.length; i++)
      //       Visibility(
      //         maintainState: true,
      //         visible: _currentIndex == i,
      //         child: _hasVisted[i]
      //             ? _buildWidget(i)
      //             : (_currentIndex == i ? _buildWidget(i) : Container()),
      //       ),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            _pageController.animateToPage(
              value,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
      ),
    );
  }
}
//?test home page

class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController tController;

  @override
  void initState() {
    tController = TextEditingController();
    print(tController);
    super.initState();
  }

  @override
  void dispose() {
    print("dispose test home page");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("now build home ");
    return const Center(child: Text("Home"));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
//?test search page

class TestSearchPage extends StatefulWidget {
  const TestSearchPage({super.key});

  @override
  State<TestSearchPage> createState() => _TestSearchPageState();
}

class _TestSearchPageState extends State<TestSearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    print("dispose search home page");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("now build search ");

    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (c) {
                  return const Scaffold(body: Center(child: Text("test")));
                },
              ),
              (r) => false,
            );
          },
          child: Text("Search"),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TestSearchController {
  static TestSearchController? _instance;

  TestSearchController._internal() {
    //?
    print("TestSearchController");
  }

  factory TestSearchController() {
    return _instance ??= TestSearchController._internal();
  }
}

class TestHomeController {
  static TestHomeController? _instance;

  TestHomeController._internal() {
    //?
    print("TestHomeController");
  }

  factory TestHomeController() {
    return _instance ??= TestHomeController._internal();
  }
}

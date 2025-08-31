import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/app_logo_widget.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/padding_manager.dart';
import '../widgets/home_page_app_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: PaddingManager.pw16,
            ),
            child: Column(
              children: [
                HomePageAppBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

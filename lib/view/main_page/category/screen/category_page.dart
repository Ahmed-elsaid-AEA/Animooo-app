import 'package:animooo/core/database/api/api_constants.dart';
import 'package:animooo/core/database/hive/hive_helper.dart';
import 'package:animooo/core/resources/border_radius_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/buttons/app_button.dart';
import 'package:animooo/core/widgets/loading/app_model_progress_hud.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:animooo/core/widgets/user_small_info.dart';
import 'package:animooo/view/main_page/category/widget/category_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../controller/category_page_controller.dart';
import '../../../../core/resources/assets_values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/fonts_size_manager.dart';

import '../../../../core/resources/padding_manager.dart';
import '../../../../core/widgets/spacing/vertical_space.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  late CategoryPageController _categoryPageController;

  @override
  void initState() {
    super.initState();
    _categoryPageController = CategoryPageController(context);
  }

  @override
  Widget build(BuildContext context) {
    print("build category page");
    super.build(context);
    return AppModelProgressHud(
      loadingOutputStream:
          _categoryPageController.loadingScreenStateOutPutStream,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: PaddingManager.pw16,
                vertical: PaddingManager.ph12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ConstsValuesManager.createNewCategory,
                    style: TextStyle(
                      fontSize: FontSizeManager.s20,
                      fontFamily: FontsManager.otamaEpFontFamily,
                      color: ColorManager.kPrimaryColor,
                    ),
                  ),
                  VerticalSpace(HeightsManager.h12),
                  UserSmallINfo(),
                  VerticalSpace(HeightsManager.h22),
                  CategoryFormField(
                    categoryFormKey: _categoryPageController.categoryFormKey,
                    onChanged: _categoryPageController.onChanged,
                    onTapAtSelectImage:
                        _categoryPageController.onTapAtSelectImage,
                    selectImageStatus:
                        _categoryPageController.selectImageStatus,
                    categoryImageOutputStream:
                        _categoryPageController.categoryFileImageOutPutStream,
                    categoryNameController:
                        _categoryPageController.categoryNameController,
                    categoryDescriptionController:
                        _categoryPageController.categoryDescriptionController,

                  ),
                  VerticalSpace(HeightsManager.h31),
                  StreamBuilder<String>(
                    initialData: ConstsValuesManager.save,
                    stream: _categoryPageController
                        .saveAndEditButtonTextOutPutStream,
                    builder: (context, snapshot) => AppButton(
                      text: snapshot.data!,
                      onTap: () {
                        // HiveHelper h = HiveHelper(
                        //   ConstsValuesManager.rememberMeBoxName,
                        // );
                        // h.deleteValue(
                        //   key: ConstsValuesManager.rememberMe,
                        // );
                        _categoryPageController.onTapSaveAndUpdateButton();
                      },
                      buttonStatusOutputStream:
                          _categoryPageController.saveButtonStatusOutPutStream,
                    ),
                  ),
                  VerticalSpace(HeightsManager.h5),
                  StreamBuilder<String>(
                    stream: _categoryPageController
                        .saveAndEditButtonTextOutPutStream,
                    builder: (context, snapshot) =>
                        snapshot.data == ConstsValuesManager.update
                        ? AppButton(
                            text: ApiConstants.delete,
                            onTap: () {
                              _categoryPageController.onTapDeleteButton();
                            },
                            buttonStatusOutputStream: _categoryPageController
                                .saveButtonStatusOutPutStream,
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

import 'package:animooo/controller/animal_page_controller.dart';
import 'package:animooo/core/widgets/user_small_info.dart';
import 'package:animooo/view/main_page/animal_page/widget/animal_form_field.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/border_radius_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/heights_manager.dart';
import '../../../core/resources/padding_manager.dart';
import '../../../core/resources/width_manager.dart';
import '../../../core/widgets/loading/app_model_progress_hud.dart';
import '../../../core/widgets/spacing/horizontal_space.dart';
import '../../../core/widgets/spacing/vertical_space.dart';

class AnimalPage extends StatefulWidget {
  const AnimalPage({super.key});

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage>
    with AutomaticKeepAliveClientMixin {
  late AnimalPageController _animalPageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animalPageController = AnimalPageController(context);
  }

  @override
  Widget build(BuildContext context) {
    print("animal page");
    super.build(context);
    return AppModelProgressHud(
      loadingOutputStream: _animalPageController.loadingScreenStateOutPutStream,
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
                    ConstsValuesManager.createNewAnimal,
                    style: TextStyle(
                      fontSize: FontSizeManager.s20,
                      fontFamily: FontsManager.otamaEpFontFamily,
                      color: ColorManager.kPrimaryColor,
                    ),
                  ),
                  VerticalSpace(HeightsManager.h12),
                  UserSmallINfo(),
                  VerticalSpace(HeightsManager.h22),
                  AnimalFormField(
                    animalPriceController:
                        _animalPageController.animalPriceController,
                    onChanged: (value) {},
                    onTapAtSelectImage: (value) {},
                    selectImageStatus: _animalPageController.selectImageStatus,
                    animalImageOutputStream:
                        _animalPageController.animalFileImageOutPutStream,
                    animalNameController:
                        _animalPageController.animalNameController,
                    animalDescriptionController:
                        _animalPageController.animalDescriptionController,
                    animalFormKey: _animalPageController.animalFormKey,
                    listCategory: _animalPageController.listCategory,
                    onSelectedCategory:
                        _animalPageController.onSelectedCategory,
                    selectedIndexCategory:
                        _animalPageController.selectedIndexCategory,
                  ),
                  VerticalSpace(HeightsManager.h31),
                  // StreamBuilder<String>(
                  //   initialData: ConstsValuesManager.save,
                  //   stream: _categoryPageController
                  //       .saveAndEditButtonTextOutPutStream,
                  //   builder: (context, snapshot) => AppButton(
                  //     text: snapshot.data!,
                  //     onTap: () {
                  //       // HiveHelper h = HiveHelper(
                  //       //   ConstsValuesManager.rememberMeBoxName,
                  //       // );
                  //       // h.deleteValue(
                  //       //   key: ConstsValuesManager.rememberMe,
                  //       // );
                  //       _categoryPageController.onTapSaveAndUpdateButton();
                  //     },
                  //     buttonStatusOutputStream:
                  //     _categoryPageController.saveButtonStatusOutPutStream,
                  //   ),
                  // ),
                  // VerticalSpace(HeightsManager.h5),
                  // StreamBuilder<String>(
                  //   stream: _categoryPageController
                  //       .saveAndEditButtonTextOutPutStream,
                  //   builder: (context, snapshot) =>
                  //   snapshot.data == ConstsValuesManager.update
                  //       ? AppButton(
                  //     text: ApiConstants.delete,
                  //     onTap: () {
                  //       _categoryPageController
                  //           .onTapDeleteButton();
                  //     },
                  //     buttonStatusOutputStream: _categoryPageController
                  //         .saveButtonStatusOutPutStream,
                  //   )
                  //       : SizedBox(),
                  // ),
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

//TODO :: don't forget change name of user and image in animal page and category and user

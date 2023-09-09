import 'package:flutter/material.dart';
import 'package:semaphore_web/src/views/setting_page/components/drawer_list_item_widget.dart';
import 'package:semaphore_web/src/views/setting_page/components/user_info_widget.dart';
import 'package:semaphore_web/src/views/setting_page/model/drawer_model.dart';
import 'package:get/get.dart';
import 'package:semaphore_web/global/constant/resources/import_resources.dart';
import 'package:semaphore_web/src/routes/app_pages.dart';
import 'package:semaphore_web/src/views/setting_page/controller/setting_page_controller.dart';

const ksWidgetHorizontalSpace15 = 15.0;
const ksWidgetVerticalSpace15 = 15.0;

class SettingPageView extends GetView<SettingPageController> {
  SettingPageView({super.key});

  final SettingPageController settingPageController = Get.put(SettingPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kcPrimaryColor,
        body: SafeArea(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 25, child: InkWell(onTap: () => Get.offAllNamed(Routes.dashboardScreen), child: Container(color: AppColors.kcWhite, height: double.infinity))),
          buildDrawerContainer(controller)
        ])));
  }

  buildDrawerContainer(controller) {
    return Expanded(
        flex: 80,
        child: Container(
            height: Get.height,
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const UserInfoWidget(),
              dividerColorCapitalLightGray(),
              const SizedBox(height: ksWidgetVerticalSpace15),
              buildDrawerList(),
              const Expanded(child: SizedBox()),
              dividerColorCapitalLightGray(),
              const SizedBox(height: ksWidgetVerticalSpace15),
              buildDrawerBottomList(),
              const SizedBox(height: ksWidgetVerticalSpace15),
            ])));
  }

  dividerColorCapitalLightGray({double? opacity}) {
    return Divider(color: AppColors.kcCaptionLightGray.withOpacity(opacity ?? 1), thickness: 2);
  }

  buildDrawerList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.drawerList.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildTopDrawerItem(controller.drawerList[index]);
      },
    );
  }

  buildTopDrawerItem(DrawerModel drawerModel) {
    return Obx(() => DrawerListItemWidget(
        displayLang: drawerModel.selectedTile == 0 ? true : false,
        isDecorated: controller.selectedDrawerMenu.value == drawerModel.selectedTile,
        drawerModel: drawerModel,
        onTap: () => controller.onDrawerItemTap(drawerModel: drawerModel)));
  }

  buildDrawerBottomList() {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return buildBottomDrawerItem(controller.drawerBottomList[index]);
        },
        itemCount: controller.drawerBottomList.length);
  }

  buildBottomDrawerItem(DrawerModel drawerModel) {
    return Obx(() => DrawerListItemWidget(
        displayLang: false,
        isDecorated: controller.selectedBottomDrawerMenu.value == drawerModel.selectedTile,
        drawerModel: drawerModel,
        onTap: () => controller.onBottomItemTap(drawerModel: drawerModel)));
  }

  buildBoxDecoration() {
    return BoxDecoration(color: const Color.fromRGBO(162, 168, 181, 0.35), borderRadius: BorderRadius.circular(8));
  }
}

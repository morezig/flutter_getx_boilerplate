import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_setup/global/utils/logger.dart';
import 'package:flutter_setup/src/views/clusters_page/clusters_page_view.dart';
import 'package:flutter_setup/src/views/dashboard/model/bottom_navigation_item_model.dart';
import 'package:flutter_setup/src/views/home_page/home_page_view.dart';
import 'package:flutter_setup/src/views/setting_page/setting_page_view.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_setup/global/constant/resources/import_resources.dart';
import 'package:flutter_setup/src/views/dashboard/component/bottom_navigation/bottom_navigation_child_view.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();
  DateTime backPressedTime = DateTime.now();
  RxInt currentTabIndex = 0.obs;

  RxList<Widget> widgetOptions = <Widget>[
    HomePageView(),
    ClustersPageView(),
    // const BottomNavigationChild(index: 2),
    const BottomNavigationChild(index: 3),
    SettingPageView(),
  ].obs;

  RxList<BottomNavigationItemModel> bottomNavigationList = <BottomNavigationItemModel>[
    BottomNavigationItemModel(
      title: R.strings.ksDashboardHome,
      activeImagePath: AppAssets.icActiveBottomHome,
      deActiveImagePath: AppAssets.icDeActiveBottomHome,
    ),
    BottomNavigationItemModel(
      title: R.strings.ksDashboardClusters,
      activeImagePath: AppAssets.icActiveBottomOrder,
      deActiveImagePath: AppAssets.icDeActiveBottomOrder,
    ),
    BottomNavigationItemModel(
      title: R.strings.ksDashboardNotification,
      activeImagePath: AppAssets.icActiveBottomNotification,
      deActiveImagePath: AppAssets.icDeActiveBottomNotification,
    ),
    BottomNavigationItemModel(
      title: R.strings.ksDashboardSetting,
      activeImagePath: AppAssets.icActiveBottomSetting,
      deActiveImagePath: AppAssets.icDeActiveBottomSetting,
    )
  ].obs;

  Future<bool> onBackCalled(BuildContext context) async {
    var difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();
    if (difference >= const Duration(seconds: 2)) {
      toast(context: context, R.strings.ksExitApp);
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }

  changeTabIndex(int index) {
    currentTabIndex.value = index;
    if (currentTabIndex.value == 0) {
      Logger.logPrint('Bottom Menu-1');
    } else if (currentTabIndex.value == 1) {
      Logger.logPrint('Bottom Menu-2');
    } else if (currentTabIndex.value == 2) {
      Logger.logPrint('Bottom Menu-3');
    } else if (currentTabIndex.value == 3) {
      Logger.logPrint('Bottom Menu-4');
    }
  }
}

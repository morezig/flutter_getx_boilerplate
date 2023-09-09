import 'dart:ui';

import 'package:flutter_setup/global/preference/user_preference.dart';
import 'package:flutter_setup/global/utils/config.dart';
import 'package:flutter_setup/global/utils/logger.dart';
import 'package:flutter_setup/src/routes/app_pages.dart';
import 'package:flutter_setup/src/views/setting_page/model/drawer_model.dart';
import 'package:get/get.dart';
import 'package:flutter_setup/global/constant/resources/resources.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../global/dialog/dialog_helper.dart';

class SettingPageController extends GetxController {
  static SettingPageController get to => Get.find();
  var drawerList = <DrawerModel>[].obs;
  var drawerBottomList = <DrawerModel>[].obs;
  RxInt selectedBottomDrawerMenu = 0.obs, selectedDrawerMenu = 0.obs;

  @override
  void onReady() {
    super.onReady();
    drawerList.addAll(getTopDrawerList());
    drawerBottomList.addAll(getBottomDrawerList());
  }

  onDrawerItemTap({required DrawerModel drawerModel}) {
    selectedDrawerMenu.value = drawerModel.selectedTile;
    switch (drawerModel.selectedTile) {
      case 0:
        Get.toNamed(Routes.changeLanguageScreen);
        Logger.logPrint(drawerModel.title);
        break;
      case 1:
        Logger.logPrint(drawerModel.title);
        openGithub(url: Config.githubRepoLink);
        break;
      case 2:
        Get.toNamed(Routes.moreScreen);
        Logger.logPrint(drawerModel.title);
        break;
    }
  }

  onBottomItemTap({required DrawerModel drawerModel}) {
    selectedBottomDrawerMenu.value = drawerModel.selectedTile;
    switch (drawerModel.selectedTile) {
      case 0:
        Logger.logPrint(drawerModel.title);
        showCommonDialogue(title: R.strings.ksDeleteAccount, description: R.strings.ksDeleteAccountDescription);
        break;
      case 1:
        Logger.logPrint(drawerModel.title);
        showCommonDialogue(title: R.strings.ksDeactivateAccount, description: R.strings.ksDeactivateAccountDescription);
        break;
      case 2:
        Logger.logPrint(drawerModel.title);
        showCommonDialogue(
            onPositiveButtonTap: () {
              AppSession.logoutUser();
            },
            title: R.strings.ksLogOut,
            description: R.strings.ksLogoutAccountDescription);
        break;
    }
  }

  Future<void> openGithub({required String url}) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  showCommonDialogue({required String title, required String description, VoidCallback? onPositiveButtonTap, onNegativeButtonTap}) {
    DialogueHelper.showCommonDialogue(
      onPositiveClick: onPositiveButtonTap ??
          () {
            Get.back();
          },
      onNegativeClick: onNegativeButtonTap ??
          () {
            Get.back();
          },
      title: title,
      description: description,
      positiveBtnText: R.strings.ksYes,
      cancelBtnText: R.strings.ksNo,
    );
  }
}

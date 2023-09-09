import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:flutter_setup/global/constant/resources/import_resources.dart';
import 'package:flutter_setup/src/views/dashboard/model/bottom_navigation_item_model.dart';

class BottomNavigationItemIcon extends StatelessWidget {
  final BottomNavigationItemModel bottomNavigationItemModel;
  final bool isActive;

  const BottomNavigationItemIcon({
    Key? key,
    required this.bottomNavigationItemModel,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SvgPicture.asset(isActive ? bottomNavigationItemModel.activeImagePath : bottomNavigationItemModel.deActiveImagePath),
      SizedBox(height: Get.height * 0.009),
      Text(
        bottomNavigationItemModel.title,
        style: AppStyles.selectedLabelStyle,
      ),
      isActive
          ? Column(children: [
              SizedBox(height: Get.height * 0.009),
              Container(
                width: Get.width * 0.06,
                height: Get.height * 0.006,
                color: AppColors.kcYellow,
              ),
            ])
          : Container()
    ]);
  }
}

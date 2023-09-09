import 'package:flutter/material.dart';
import 'package:semaphore_web/global/constant/resources/import_resources.dart';

class BottomNavigationChild extends StatelessWidget {
  final int index;

  const BottomNavigationChild({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        index == 2 ? R.strings.ksDashboardOrder : R.strings.ksDashboardNotification,
        style: AppStyles.txt24sizeW600kcCaptionLightGray.merge(
          const TextStyle(
            color: AppColors.kcPrimaryColor,
          ),
        ),
      ),
    );
  }
}

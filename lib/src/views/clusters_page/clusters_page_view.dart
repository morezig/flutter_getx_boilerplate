import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constant/resources/colors.dart';
import 'controller/clusters_page_controller.dart';

class ClustersPageView extends GetView<ClustersPageController> {
  ClustersPageView({super.key});

  final ClustersPageController clustersPageController = Get.put(ClustersPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kcWhite,
      body: SafeArea(
        child: Column(
          children: [
            Text("Clusters"),
            InkWell(
              onTap: () {
                clustersPageController.getCMDBPgCluster();
              },
              child: Text("get CMDB PG_Cluster"),
            ),
          ],
        ),
      ),
    );
  }
}

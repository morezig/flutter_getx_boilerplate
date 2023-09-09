import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/clusters_page_controller.dart';

class ClustersPageView extends GetView<ClustersPageController> {
  ClustersPageView({super.key});

  final ClustersPageController clustersPageController = Get.put(ClustersPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.kcWhite,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Clusters"),
                    InkWell(
                      onTap: () {
                        clustersPageController.getCMDBPgCluster();
                      },
                      child: const Text("Refresh Clusters"),
                    ),
                  ],
                )),
            Expanded(
              flex: 8,
              child: Obx(
                () => ListView.builder(
                    itemCount: clustersPageController.clusterList.length,
                    itemBuilder: (context, index) {
                      print("idx:${index}");
                      return ListTile(
                        title: Text('Name: ${clustersPageController.clusterList[index].name}'),
                        leading: Text('Id: ${clustersPageController.clusterList[index].id}'),
                        trailing: IconButton(
                          onPressed: () {
                            print('${clustersPageController.clusterList[index].id} press');
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

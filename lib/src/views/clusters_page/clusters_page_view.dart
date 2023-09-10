import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semaphore_web/src/views/clusters_page/model/cluster_model.dart';

import '../../routes/app_pages.dart';
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
                        Get.toNamed(
                          Routes.clusterScreen,
                          arguments: [
                            {"cluster": ClusterModel(id: 0)},
                          ],
                        );
                      },
                      child: const Text("Add Cluster"),
                    ),
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
                            Get.toNamed(
                              Routes.clusterScreen,
                              arguments: [
                                {"cluster": clustersPageController.clusterList[index]},
                              ],
                            );
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

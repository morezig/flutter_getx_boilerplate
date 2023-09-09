import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:semaphore_web/src/views/clusters_page/model/cluster_model.dart';

import '../../../../global/apis/dio_client.dart';

class ClustersPageController extends GetxController {
  static ClustersPageController get to => Get.find();

  var clusterList = <ClusterModel>[].obs;

  // /api/project/1/inventory
  Future<void> getCMDBPgCluster() async {
    try {
      var response = await DioClient.instance.get(
        "/api/project/1/inventory",
      );
      var modelClusters = (response as List).map((x) => ClusterModel.fromJson(x)).toList();
      clusterList.clear();
      clusterList.addAll(modelClusters);
    } on DioException catch (e) {
      print("DioException:${e.message}");
      rethrow;
    } catch (ex) {
      print("Exception:$ex");
      // rethrow;
    }
  }
}

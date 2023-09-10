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

  Future<int> getAccessKey(ClusterModel cluster) async {
    int retKeyId = 0;
    try {
      var response = await DioClient.instance.get(
        "/api/project/1/keys",
      );
      for (var element in (response as List)) {
        if (element['name'] == "${cluster.name}-keys") {
          retKeyId = element['id'];
          break;
        }
      }
    } on DioException catch (e) {
      print("DioException:${e.message}");
      rethrow;
    } catch (ex) {
      print("Exception:$ex");
      // rethrow;
    }
    return retKeyId;
  }

  Future<void> addAccessKey(ClusterModel cluster, String privateKey) async {
    try {
      var response = await DioClient.instance.post(
        "/api/project/1/keys",
        data: {
          "project_id": 1,
          "type": "ssh",
          "ssh": {
            "private_key": privateKey,
          },
          "name": "${cluster.name}-keys",
        },
      );
      print('[addAccessKey]:response:$response');
    } on DioException catch (e) {
      print("DioException:${e.message}");
      rethrow;
    } catch (ex) {
      print("Exception:$ex");
      // rethrow;
    }
  }

  Future<ClusterModel> addInventory(ClusterModel cluster) async {
    ClusterModel retCluster = ClusterModel();
    try {
      var response = await DioClient.instance.post(
        "/api/project/1/inventory",
        data: cluster.toJson(),
      );
      var modelCluster = ClusterModel.fromJson(response);
      clusterList.add(modelCluster);
      retCluster = modelCluster;
    } on DioException catch (e) {
      print("DioException:${e.message}");
      rethrow;
    } catch (ex) {
      print("Exception:$ex");
      // rethrow;
    }

    return retCluster;
  }

  Future<void> addTemplate(ClusterModel cluster, String tplName) async {
    try {
      var response = await DioClient.instance.post(
        "/api/project/1/templates",
        data: {
          "project_id": 1,
          "repository_id": 1,
          "inventory_id": cluster.id,
          "environment_id": 1,
          "name": '${cluster.name}-$tplName',
          "playbook": "$tplName.yml",
        },
      );
    } on DioException catch (e) {
      print("DioException:${e.message}");
      rethrow;
    } catch (ex) {
      print("Exception:$ex");
      // rethrow;
    }
  }
}

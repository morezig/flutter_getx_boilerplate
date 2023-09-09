import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../global/apis/dio_client.dart';

class ClustersPageController extends GetxController {
  static ClustersPageController get to => Get.find();

  Future<String> getCMDBPgCluster() async {
    try {
      final response = await DioClient.instance.get(
        "/api/crys/metaview/pg_cluster",
      );

      print(response);

      return "";
    } on DioException catch (e) {
      print("============>${e.message}");
      rethrow;
    }
  }
}

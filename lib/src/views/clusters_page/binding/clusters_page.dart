import 'package:get/get.dart';

import '../controller/clusters_page_controller.dart';

class ClustersPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClustersPageController>(() => ClustersPageController());
  }
}

import 'package:get/get.dart';

import 'package:semaphore_web/src/views/dashboard/controller/dashboard_controller.dart';

class DashboradBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}

import 'package:get/get.dart';

import 'package:flutter_setup/src/views/dashboard/controller/dashboard_controller.dart';

class DashboradBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
  }
}

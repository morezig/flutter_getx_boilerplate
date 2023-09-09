import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semaphore_web/global/utils/logger.dart';
import 'package:semaphore_web/global/utils/network.dart';
import 'package:get_storage/get_storage.dart';
import 'package:semaphore_web/flutter_boilerplate.dart';
import 'package:semaphore_web/global/preference/user_preference.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorage.init();
    AppSession.init();
    Network.getInstance();
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    runApp(const FlutterBoilerPlateApp());
  }, (error, stackTrace) {
    Logger.logPrint("Main======>>>>${error.toString()}");
  });
}

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_setup/global/preference/user_preference.dart';
import 'package:flutter_setup/global/utils/logger.dart';
import 'package:flutter_setup/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_setup/global/constant/resources/resources.dart';
import 'package:flutter_setup/global/utils/utils.dart';

import '../../../../../global/apis/dio_client.dart';

class LoginScreenController extends GetxController {
  var isShowPassword = false.obs;

  late GlobalKey<FormState> loginScreenFormKey;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  String generateRandomString(int len) {
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  loginValidation() async {
    var loginOk = await login(emailTextEditingController.text, passwordTextEditingController.text);
    if (loginOk) {
      var token = await getToken();
      AppSession.setAccessToken(token);
      Utils.successSnackBar(message: R.strings.scLoginMsg);
      Get.offAllNamed(Routes.dashboardScreen);
    } else {
      Utils.errorSnackBar(message: R.strings.scLoginFailMsg);
      Logger.logPrint('invalidate');
    }
  }

  Future<bool> login(String name, String pwd) async {
    try {
      final response = await DioClient.instance.post(
        "/api/auth/login",
        data: {
          'auth': name,
          'password': pwd,
        },
      );
      // return NewUser.fromJson(response);
      return true;
    } on DioException catch (e) {
      print("============>${e.message}");
      // throw e;
      return false;
    }
  }

  Future<void> logout() async {
    try {
      final response = await DioClient.instance.post(
        "/api/auth/logout",
        data: {},
      );

      DioClient.instance.setToken("");
    } on DioException catch (e) {
      print("============>${e.message}");
      rethrow;
    }
  }

  Future<String> getToken() async {
    try {
      final response = await DioClient.instance.post(
        "/api/user/tokens",
        data: {},
      );
      if (response['id'] != null) {
        DioClient.instance.setToken(response['id']);
      }
      return response['id'];
    } on DioException catch (e) {
      print("============>${e.message}");
      rethrow;
    }
  }

  Future<void> testAuthReq() async {
    try {
      final response = await DioClient.instance.get(
        "/api/crys/ping",
      );
      print(response);
    } on DioException catch (e) {
      print("============>${e.message}");
      // throw e;
    }
  }
}

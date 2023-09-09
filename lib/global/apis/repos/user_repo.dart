import 'package:dio/dio.dart';

import '../dio_client.dart';

class UserRepos {
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

  Future<void> getToken() async {
    try {
      final response = await DioClient.instance.post(
        "/api/user/tokens",
        data: {},
      );
      if (response['id'] != null) {
        DioClient.instance.setToken(response['id']);
      }
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

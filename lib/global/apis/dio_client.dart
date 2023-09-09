import 'package:dio/dio.dart';

import '../utils/config.dart';

class DioClient {
  DioClient._();

  static final instance = DioClient._();

  final Dio _dio = Dio(BaseOptions(baseUrl: Config.apiBaseUrl, connectTimeout: const Duration(seconds: 60), receiveTimeout: const Duration(seconds: 60), responseType: ResponseType.json));

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  ///Get Method
  Future<Map<String, dynamic>> get(String path, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print("[GET]response:${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } on DioException catch (e) {
      print("[DioException]Error code:${e.response?.statusCode}");
      if (e.response?.statusCode == 400) {
        return e.response?.data;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  ///Post Method
  Future<Map<String, dynamic>> post(String path,
      {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      print("[POST]response:${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
        // for login
      } else if (response.statusCode == 204) {
        return <String, dynamic>{};
      }
      throw "something went wrong";
    } on DioException catch (e) {
      print("[DioException]Error code:${e.response?.statusCode}");
      if (e.response?.statusCode == 400) {
        return e.response?.data;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  ///Put Method
  Future<Map<String, dynamic>> put(String path,
      {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print("[PUT]response:${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } on DioException catch (e) {
      print("[DioException]Error code:${e.response?.statusCode}");
      if (e.response?.statusCode == 400) {
        return e.response?.data;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  ///Delete Method
  Future<dynamic> delete(String path,
      {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      print("[DELETE]response:${response.data}");
      if (response.statusCode == 204) {
        return response.data;
      }
      throw "something went wrong";
    } on DioException catch (e) {
      print("[DioException]Error code:${e.response?.statusCode}");
      if (e.response?.statusCode == 400) {
        return e.response?.data;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}

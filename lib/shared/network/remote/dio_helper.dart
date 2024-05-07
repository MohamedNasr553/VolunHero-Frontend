import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://volunhero.onrender.com/api',
        receiveDataWhenStatusError: true,
      ),
    );

    // Add interceptors for error handling
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError error, handler) {
          // Handle error here, e.g., log, show toast, etc.
          print('$error');
          // Continue processing the error
          return handler.next(error);
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(headers: {'authorization': 'Volunhero__$token'}),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(headers: {'authorization': 'Volunhero__$token'}),
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return dio.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(headers: {'authorization': 'Volunhero__$token'}),
    );
  }

  static Future<Response> patchData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      return dio.patch(
        url,
        queryParameters: query,
        data: data,
        options: Options(headers: {
          'authorization': 'Volunhero__$token',
        }),
      );
    } catch (e) {
      throw Exception('Failed to patch data: $e');
    }
  }
}

import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: "https://newsapi.org/v2/",
      receiveDataWhenStatusError: true,
    );
    dio = Dio(baseOptions);
  }

  static Future getData({
    required String path,
    Map<String,dynamic>? queryParameters,
  }) async {
   return await dio?.get(
      path,
      queryParameters: queryParameters,
    );
  }
}

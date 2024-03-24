import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

String TestingUrl = "http://192.168.123.111:8000/";

class Constant {
  static String Baseurl = "${TestingUrl}api";

  static String ImagebaseUrl = '$TestingUrl';

  Dio _dio = Dio();

  Constant() {
    BaseOptions options = new BaseOptions(
      baseUrl: Baseurl,
      // receiveDataWhenStatusError: true, connectTimeout: Duration(seconds: 25), // 60 seconds
      // receiveTimeout: Duration(seconds: 25) // 60 seconds
    );
    _dio.options = options;

    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}

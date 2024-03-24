

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import 'Constant.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  Constant api = Constant();

  HttpUtil._internal() {
    api.sendRequest.interceptors.add(PrettyDioLogger());
  }

  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameteres,
      FormData? formdata,
      String? type}) async {
    try {
      var response = await api.sendRequest.post(path,
          data: type == "formdata" ? formdata : data,
          queryParameters: queryParameteres);

      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.connectionTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          throw "An error occured please try again!";
        } else if (e.type == DioErrorType.badResponse) {

          throw "Oops! Something Went Wrong";

        } else if (e.type == DioErrorType.unknown) {
          throw "Oops! Something Went Wrong";
        } else if (e.type == DioErrorType.connectionError) {
          throw "An error occured please try again!";
        }
      } else {
        throw "Oops! Something Went Wrong";
      }
    }
  }



  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      // api.sendRequest.options.headers["authorization"] = "Bearer ${Global.storageServices.getaccesstoken()!}";
      // api.sendRequest.options.headers['accept'] = 'application/json';
      api.sendRequest.options.headers['content-type'] = 'application/json';
      var response = await api.sendRequest.get(path, queryParameters: data);
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.connectionTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          throw "Oops! Something Went Wrong";
        } else if (e.type == DioErrorType.badResponse) {
          throw "Oops! Something Went Wrong";
        } else if (e.type == DioErrorType.unknown) {
          throw "Oops! Something Went Wrong";
        } else if (e.type == DioErrorType.connectionError) {
          throw "An error occured please try again!";
        }
      } else {
        throw "Oops! Something Went Wrong";
      }
    }
  }
}

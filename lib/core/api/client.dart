import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:web_translator_ml/core/api/api_interceptors.dart';

@lazySingleton
class Client {
  Dio init() {
    Dio dio = Dio();
    dio.interceptors.add(ApiInterceptors());
    return dio;
  }
}

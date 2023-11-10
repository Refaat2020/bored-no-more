import 'package:dio/dio.dart';

import '../constants/app_urls.dart';


class DioConfigOptions {
  static Future<BaseOptions> getBaseOption() async {
    BaseOptions options = BaseOptions(
        baseUrl: AppUrl.stagingUrl,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
        headers: {
          'Content-type': 'application/json',

        });

    return options;
  }
}

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:survey_client/api.dart';

class HttpUtils {
  static SurveyClient getSurveyClient() {
    SurveyClient client = SurveyClient();
    (client.dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return client;
  }

  static void registerToken(String token) {
    GetIt.instance
        .get(instanceName: "surveyClient")
        .dio
        .interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers["Authorization"] = 'Bearer $token';
    }));
  }
}

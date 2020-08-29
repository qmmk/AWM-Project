import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:survey_client/api.dart';

class HttpUtils {
  static final String _refreshTokenKey = "refreshToken";

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

  static Future<void> storeRefreshToken(String refreshToken) async {
    FlutterSecureStorage secureStorage = GetIt.instance.get(instanceName: "secureStorage");
    return secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  static Future<String> getRefreshToken() async {
    FlutterSecureStorage secureStorage = GetIt.instance.get(instanceName: "secureStorage");
    return secureStorage.read(key: _refreshTokenKey);
  }

  static Future<void> invalidateTokens() async {
    FlutterSecureStorage secureStorage = GetIt.instance.get(instanceName: "secureStorage");
    await secureStorage.delete(key: _refreshTokenKey);
    SurveyClient client = GetIt.instance.get(instanceName: "surveyClient");
    client.dio.interceptors.removeLast();
  }
}

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:survey_client/api.dart';
import 'package:surveys/application.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';

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
    SurveyClient surveyClient = GetIt.instance.get(instanceName: "surveyClient");

    GetIt.instance
        .get(instanceName: "surveyClient")
        .dio
        .interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
          options.headers["Authorization"] = 'Bearer $token';
        }, onError: (DioError error) async {
          if (error.response.statusCode == 401) {
            surveyClient.dio.interceptors.requestLock.lock();
            surveyClient.dio.interceptors.responseLock.lock();
            
            UserAndCollectionProvider provider = GetIt.instance.get(instanceName: "userAndCollectionProvider");
            await provider.logout(onlyResetUserData: true); //Kick out the user, whatever the logout does
            globalAppNavigator.currentState.pushNamedAndRemoveUntil(Routes.accessHub, (Route<dynamic> route) => false);
            surveyClient.dio.interceptors.requestLock.unlock();
            surveyClient.dio.interceptors.responseLock.unlock();
          }
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

import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_client/api.dart';
import 'package:survey_client/model/login_request_body.dart';
import 'package:surveys/init.dart';
import 'package:surveys/logic/services/access_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*surveyClient.dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    options.headers["Authorization"] = 'Bearer $token';
  }));*/

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(ProviderScope(
      child: Init(),
    ));
  });
}

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:survey_client/api.dart';
import 'package:survey_client/model/login_request_body.dart';
import 'package:survey_client/model/login_response.dart';

class AccessService {
  SurveyClient _client;

  AccessService() {
    _client = GetIt.instance.get(instanceName: "surveyClient");
  }

  Future<LoginResponse> login({@required username, @required password}) async {
    LoginRequestBody loginRequestBody = LoginRequestBody();
    LoginRequestBodyBuilder loginRequestBodyBuilder = loginRequestBody.toBuilder();
    loginRequestBodyBuilder
      ..username = username
      ..password = password;
    loginRequestBody = loginRequestBodyBuilder.build();
    Response<LoginResponse> response = await _client.getDefaultApi().login(loginRequestBody);
    return response.data;
  }
}

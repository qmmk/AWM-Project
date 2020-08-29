import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:survey_client/api.dart';
import 'package:survey_client/model/fast_login_request_body.dart';
import 'package:survey_client/model/login_request_body.dart';
import 'package:survey_client/model/login_response.dart';
import 'package:survey_client/model/logout_response.dart';
import 'package:survey_client/model/only_pid_parameter.dart';
import 'package:survey_client/model/user.dart';

class AccessService {
  SurveyClient _client;

  AccessService() {
    _client = GetIt.instance.get(instanceName: "surveyClient");
  }

  Future<LoginResponse> login({@required String username, @required String password}) async {
    LoginRequestBody loginRequestBody = LoginRequestBody();
    LoginRequestBodyBuilder loginRequestBodyBuilder = loginRequestBody.toBuilder();
    loginRequestBodyBuilder
      ..username = username
      ..password = password;
    loginRequestBody = loginRequestBodyBuilder.build();

    Response<LoginResponse> response = await _client.getDefaultApi().login(loginRequestBody);
    return response.data;
  }

  Future<LoginResponse> fastLogin({@required String refreshToken}) async {
    FastLoginRequestBody fastLoginRequestBody = FastLoginRequestBody();
    FastLoginRequestBodyBuilder fastLoginRequestBodyBuilder = fastLoginRequestBody.toBuilder();
    fastLoginRequestBodyBuilder.token = refreshToken;
    fastLoginRequestBody = fastLoginRequestBodyBuilder.build();

    Response<LoginResponse> response = await _client.getDefaultApi().fastLogin(fastLoginRequestBody);
    return response.data;
  }

  Future<bool> signUp({@required String username, @required String password, String roleID = "0"}) async {
    User user = User();
    UserBuilder userBuilder = user.toBuilder();

    userBuilder
      ..userName = username
      ..password = password
      ..roleID = roleID;
    user = userBuilder.build();

    Response<bool> response = await _client.getDefaultApi().signUp(user);
    return response.data;
  }

  Future<LogoutResponse> logout({@required int pid}) async {
    OnlyPidParameter onlyPidParameter = OnlyPidParameter();
    OnlyPidParameterBuilder onlyPidParameterBuilder = onlyPidParameter.toBuilder();

    onlyPidParameterBuilder.pid = pid;
    onlyPidParameter = onlyPidParameterBuilder.build();

    Response<LogoutResponse> response = await _client.getDefaultApi().logout(onlyPidParameter);
    return response.data;
  }
}

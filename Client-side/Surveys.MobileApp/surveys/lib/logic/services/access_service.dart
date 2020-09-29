import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:survey_client/model/fast_login_request_body.dart';
import 'package:survey_client/model/login_request_body.dart';
import 'package:survey_client/model/login_response.dart';
import 'package:survey_client/model/only_pid_parameter.dart';
import 'package:survey_client/model/openapi_user.dart';
import 'package:surveys/logic/services/base_service.dart';

class AccessService extends BaseService {
  Future<LoginResponse> login({@required String username, @required String password}) async {
    LoginRequestBody loginRequestBody = LoginRequestBody();
    LoginRequestBodyBuilder loginRequestBodyBuilder = loginRequestBody.toBuilder();
    loginRequestBodyBuilder
      ..username = username
      ..password = password;
    loginRequestBody = loginRequestBodyBuilder.build();

    Response<LoginResponse> response = await client.getDefaultApi().login(loginRequestBody);
    return response.data;
  }

  Future<LoginResponse> fastLogin({@required String refreshToken}) async {
    FastLoginRequestBody fastLoginRequestBody = FastLoginRequestBody();
    FastLoginRequestBodyBuilder fastLoginRequestBodyBuilder = fastLoginRequestBody.toBuilder();
    fastLoginRequestBodyBuilder.token = refreshToken;
    fastLoginRequestBody = fastLoginRequestBodyBuilder.build();

    try {
      Response<LoginResponse> response = await client.getDefaultApi().fastLogin(fastLoginRequestBody);
      return response.data;
    } on Exception {
      return null;
    }
  }

  Future addUser({int pid, @required String username, @required String password, String roleID = "0"}) async {
    OpenapiUser user = OpenapiUser();
    OpenapiUserBuilder userBuilder = user.toBuilder();

    userBuilder
      ..pid = pid
      ..userName = username
      ..password = password
      ..roleID = roleID;
    user = userBuilder.build();

    var response = await client.getDefaultApi().addUser(user);
    return response.data;
  }

  Future logout({@required int pid}) async {
    OnlyPidParameter onlyPidParameter = OnlyPidParameter();
    OnlyPidParameterBuilder onlyPidParameterBuilder = onlyPidParameter.toBuilder();

    onlyPidParameterBuilder.pid = pid;
    onlyPidParameter = onlyPidParameterBuilder.build();

    var response = await client.getDefaultApi().logout(onlyPidParameter);
    return response.data;
  }
}

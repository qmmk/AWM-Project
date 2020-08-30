import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:surveys/logic/providers/base_provider.dart';
import 'package:surveys/logic/services/access_service.dart';
import 'package:surveys/logic/services/survey_service.dart';
import 'package:surveys/logic/utils/http_utils.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/user_model.dart';

class UserAndCollectionProvider extends BaseProvider {
  AccessService _accessService = AccessService();
  SurveyService _surveyService = SurveyService();

  User _user = User();
  List<Survey> _userSurveys;

  User get user => _user;
  List<Survey> get userSurveys => _userSurveys;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUsername(String username) {
    _user.username = username;
    notifyListeners();
  }

  void setPassword(String password) {}

  Future<bool> logout() async {
    try {
      await _accessService.logout(pid: _user.pid);
      await HttpUtils.invalidateTokens();
      _user = null;
      _userSurveys = null;
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  Future<void> initPersonalSurveys() async {
    if (_userSurveys != null) return;

    _userSurveys = await _surveyService.loadAllSurveysByUser(pid: _user.pid);
  }

  Future<bool> modifySurvey(int index, Survey survey) async {
    if (index < 0 || index >= _userSurveys.length || survey.id == null) return Future.value(false);

    bool success = await _surveyService.createSurvey(survey: survey);
    if (success) {
      _userSurveys[index] = survey;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> createSurvey({@required Survey survey}) async {
    survey.customField03 = _user.pid.toString();
    bool success = await _surveyService.createSurvey(survey: survey);
    if (success) {
      _userSurveys.add(survey);
      notifyListeners();
      return true;
    }

    return false;
  }
}
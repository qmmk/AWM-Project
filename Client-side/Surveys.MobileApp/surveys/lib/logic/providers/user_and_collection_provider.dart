import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:surveys/logic/providers/base_provider.dart';
import 'package:surveys/logic/services/access_service.dart';
import 'package:surveys/logic/services/survey_service.dart';
import 'package:surveys/logic/utils/http_utils.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/user_model.dart';

class UserAndCollectionProvider extends BaseProvider {
  AccessService _accessService = AccessService();
  SurveyService _surveyService = SurveyService();

  User _user = User();
  List<Survey> _userSurveys;
  List<Survey> _othersSurveys;

  User get user => _user;
  List<Survey> get userSurveys => _userSurveys;
  List<Survey> get othersSurveys => _othersSurveys;

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

  Future<void> initOthersSurveys() async {
    if (_othersSurveys != null) return;

    _othersSurveys = await _surveyService.loadAllSurveysExceptUser(pid: _user.pid);
  }

  Future<void> modifySurvey(int index, Survey survey) async {
    if (index < 0 || index >= _userSurveys.length || survey.id == null) return Future.value(false);

    Survey updated = await _surveyService.createSurvey(survey: survey);
    _userSurveys[index] = updated;
    notifyListeners();
  }

  Future<void> createSurvey({@required Survey survey}) async {
    survey.customField03 = _user.pid.toString();
    Survey created = await _surveyService.createSurvey(survey: survey);
    _userSurveys.add(created);
    notifyListeners();
  }

  Future<void> loadDetails({@required int index, @required bool isPersonal}) async {
    List<SurveyDetail> details =
        await _surveyService.getSurveyDetails(seid: isPersonal ? _userSurveys[index].id : _othersSurveys[index].id);
    if (isPersonal)
      _userSurveys[index].details = details;
    else
      _othersSurveys[index].details = details;

    notifyListeners();
  }
}

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
    } on DioError {
      return false;
    }
  }

  Future<void> loadPersonalSurveys() async {
    if (_userSurveys != null) return;

    loading();
    _userSurveys = await _surveyService.loadAllSurveysByUser(pid: _user.pid);
    done();
    notifyListeners();
  }

  Future<void> loadOthersSurveys() async {
    if (_othersSurveys != null) return;

    loading();
    _othersSurveys = await _surveyService.loadAllSurveysExceptUser(pid: _user.pid);
    done();
    notifyListeners();
  }

  Future<void> modifySurvey(int index, Survey survey) async {
    if (index < 0 || index >= _userSurveys.length || survey.id == null) return;

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
    if ((isPersonal ? _userSurveys[index].details : _othersSurveys[index].details) != null) return;

    loading();
    List<SurveyDetail> details =
        await _surveyService.getSurveyDetails(seid: isPersonal ? _userSurveys[index].id : _othersSurveys[index].id);
    if (isPersonal)
      _userSurveys[index].details = details;
    else
      _othersSurveys[index].details = details;
    done();
    notifyListeners();
  }

  Future<void> removeSurvey({@required int index, @required bool isPersonal}) async {
    loading();
    await _surveyService.deleteSurvey(seid: isPersonal ? _userSurveys[index].id : _othersSurveys[index].id);
    if (isPersonal)
      _userSurveys.removeAt(index);
    else
      _othersSurveys.removeAt(index);
    done();
    notifyListeners();
  }
}

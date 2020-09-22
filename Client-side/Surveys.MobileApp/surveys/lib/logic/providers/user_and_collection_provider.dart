import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:surveys/logic/providers/base_provider.dart';
import 'package:surveys/logic/services/access_service.dart';
import 'package:surveys/logic/services/survey_service.dart';
import 'package:surveys/logic/utils/http_utils.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/user_model.dart';
import 'package:surveys/models/vote_amount_model.dart';

class UserAndCollectionProvider extends BaseProvider {
  AccessService _accessService = AccessService();
  SurveyService _surveyService = SurveyService();

  User _user = User();
  List<Survey> _userSurveys;
  List<Survey> _othersSurveys;
  List<int> _alreadySubmittedSurveysIds;

  User get user => _user;
  List<Survey> get userSurveys => _userSurveys;
  List<Survey> get othersSurveys => _othersSurveys;

  UserAndCollectionProvider() {
    GetIt.instance.registerSingleton(this, instanceName: "userAndCollectionProvider");
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> updateUser({@required User user, @required String password}) async {
    int pid = _user.id;
    _user = user;
    _user.id = pid;
    await _accessService.addUser(pid: pid, username: _user.username, password: password);
    notifyListeners();
  }

  void setUsername(String username) {
    _user.username = username;
    notifyListeners();
  }

  void setPassword(String password) {}

  Future<bool> logout({bool onlyResetUserData = false}) async {
    try {
      if (!onlyResetUserData) await _accessService.logout(pid: _user.id);
      await HttpUtils.invalidateTokens();
      _user = null;
      _userSurveys = null;
      _othersSurveys = null;
      _alreadySubmittedSurveysIds = null;
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  Future<void> loadPersonalSurveys() async {
    loading();
    _userSurveys = await _surveyService.loadAllSurveysByUser(pid: _user.id);
    done();
    notifyListeners();
  }

  Future<void> loadOthersAndAlreadySubmittedSurveys() async {
    loading();
    _othersSurveys = await _surveyService.loadAllSurveysExceptUser(pid: _user.id);
    _alreadySubmittedSurveysIds = await _surveyService.getUserSubmittedSurveys(pid: _user.id);
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
    survey.userId = _user.id;
    Survey created = await _surveyService.createSurvey(survey: survey);
    if (_userSurveys != null) _userSurveys.add(created);
    notifyListeners();
  }

  Future<bool> loadDetails({@required int index, @required bool isPersonal}) async {
    try {
      loading();
      List<SurveyDetail> details =
          await _surveyService.getSurveyDetails(seid: isPersonal ? _userSurveys[index].id : _othersSurveys[index].id);
      if (isPersonal)
        _userSurveys[index].details = details;
      else
        _othersSurveys[index].details = details;
      done();
      notifyListeners();
      return true;
    } on Exception catch (e) {
      return false;
    }
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

  Future<bool> registerVote({@required int index, @required detailsIndex}) async {
    try {
      loading();
      await _surveyService.registerVote(sdid: _othersSurveys[index].details[detailsIndex].id, pid: _user.id);
      _alreadySubmittedSurveysIds.add(_othersSurveys[index].id);
      done();
      notifyListeners();
      return true;
    } on DioError {
      done();
      notifyListeners();
      return false;
    }
  }

  bool hasAlreadyVotedFor({@required int index}) => _alreadySubmittedSurveysIds.contains(_othersSurveys[index].id);

  Future<List<VoteAmount>> getSurveyVotes({@required int index, @required bool isPersonal}) async {
    loading();
    List<VoteAmount> votes =
        await _surveyService.getSurveyVotes(seid: isPersonal ? _userSurveys[index].id : _othersSurveys[index].id);
    done();
    return votes;
  }
}

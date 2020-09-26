import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:surveys/logic/providers/base_provider.dart';
import 'package:surveys/logic/providers/user_provider.dart';
import 'package:surveys/logic/services/survey_service.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/vote_amount_model.dart';

class CollectionProvider extends BaseProvider {
  UserProvider userProvider;

  SurveyService _surveyService = SurveyService();

  List<Survey> _userSurveys;
  List<Survey> _othersSurveys;
  List<int> _alreadySubmittedSurveysIds;

  List<Survey> get userSurveys => _userSurveys;
  List<Survey> get othersSurveys => _othersSurveys;

  CollectionProvider() {
    GetIt.instance.registerSingleton(this, instanceName: "collectionProvider");
  }

  Future<bool> logout() async {
    try {
      await userProvider.logout();
      resetUserData();
      return true;
    } on DioError {
      return false;
    }
  }

  void resetUserData() {
    _userSurveys = null;
    _othersSurveys = null;
    _alreadySubmittedSurveysIds = null;
  }

  Future<bool> loadPersonalSurveys() async {
    try {
      loading();
      _userSurveys = await _surveyService.loadAllSurveysByUser(pid: userProvider.user.id);
      done();
      notifyListeners();
      return true;
    } on DioError {
      done();
      notifyListeners();
      return false;
    }
  }

  Future<bool> loadOthersAndAlreadySubmittedSurveys() async {
    try {
      loading();
      _othersSurveys = await _surveyService.loadAllSurveysExceptUser(pid: userProvider.user.id);
      _alreadySubmittedSurveysIds = await _surveyService.getUserSubmittedSurveys(pid: userProvider.user.id);
      done();
      notifyListeners();
      return true;
    } on DioError {
      done();
      notifyListeners();
      return false;
    }
  }

  Future<bool> modifySurvey(int index, Survey survey) async {
    if (index < 0 || index >= _userSurveys.length || survey.id == null) return false;

    try {
      Survey updated = await _surveyService.createSurvey(survey: survey);
      _userSurveys[index] = updated;
      notifyListeners();
      return true;
    } on DioError {
      notifyListeners();
      return false;
    }
  }

  Future<bool> createSurvey({@required Survey survey}) async {
    try {
      survey.userId = userProvider.user.id;
      Survey created = await _surveyService.createSurvey(survey: survey);
      if (_userSurveys != null) _userSurveys.add(created);
      notifyListeners();
      return true;
    } on DioError {
      notifyListeners();
      return false;
    }
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
    } on DioError {
      done();
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeSurvey({@required int index, @required bool isPersonal}) async {
    try {
      loading();
      await _surveyService.deleteSurvey(seid: isPersonal ? _userSurveys[index].id : _othersSurveys[index].id);
      if (isPersonal)
        _userSurveys.removeAt(index);
      else
        _othersSurveys.removeAt(index);
      done();
      notifyListeners();
      return true;
    } on DioError {
      done();
      notifyListeners();
      return false;
    }
  }

  Future<bool> registerVote({@required int index, @required detailsIndex}) async {
    try {
      loading();
      await _surveyService.registerVote(
          sdid: _othersSurveys[index].details[detailsIndex].id, pid: userProvider.user.id);
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
    try {
      loading();
      List<VoteAmount> votes =
          await _surveyService.getSurveyVotes(seid: isPersonal ? _userSurveys[index].id : _othersSurveys[index].id);
      done();
      return votes;
    } on DioError {
      done();
      return Future.value(null);
    }
  }
}

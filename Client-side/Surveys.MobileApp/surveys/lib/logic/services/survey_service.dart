import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:survey_client/model/openapi_survey.dart';
import 'package:survey_client/model/openapi_survey_detail.dart';
import 'package:survey_client/model/openapi_vote.dart';
import 'package:surveys/logic/services/base_service.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/vote_model.dart';

class SurveyService extends BaseService {
  Survey _convertOpenapiSurveyToSurvey(OpenapiSurvey openapiSurvey) => Survey(
      id: openapiSurvey.seid,
      description: openapiSurvey.descr,
      isOpen: openapiSurvey.isOpen == "1",
      title: openapiSurvey.title,
      userId: openapiSurvey.customField03,
      details: openapiSurvey.surveyDetails?.map(_convertOpenapiSurveyDetailToSurveyDetail)?.toList());

  OpenapiSurveyDetail _convertSurveyDetailToOpenapiSurveyDetail(SurveyDetail surveyDetail) {
    OpenapiSurveyDetailBuilder openapiSurveyDetailBuilder = OpenapiSurveyDetailBuilder();
    openapiSurveyDetailBuilder
      ..sdid = surveyDetail.id
      ..seid = surveyDetail.surveyId
      ..descr = surveyDetail.description
      ..customField01 = surveyDetail.customField01
      ..customField02 = surveyDetail.customField02
      ..customField03 = surveyDetail.customField03;

    return openapiSurveyDetailBuilder.build();
  }

  OpenapiVote _convertVoteToOpenapiVote(Vote vote) {
    OpenapiVoteBuilder openapiVoteBuilder = OpenapiVoteBuilder();
    openapiVoteBuilder
      ..avid = vote.id
      ..sdid = vote.surveyDetailId
      ..pid = vote.userId
      ..customField01 = vote.customField01
      ..customField02 = vote.customField02
      ..customField03 = vote.customField03;
    return openapiVoteBuilder.build();
  }

  SurveyDetail _convertOpenapiSurveyDetailToSurveyDetail(OpenapiSurveyDetail openapiSurveyDetail) => SurveyDetail(
      id: openapiSurveyDetail.sdid,
      surveyId: openapiSurveyDetail.seid,
      description: openapiSurveyDetail.descr,
      customField01: openapiSurveyDetail.customField01,
      customField02: openapiSurveyDetail.customField02,
      customField03: openapiSurveyDetail.customField03);

  Future<List<Survey>> loadAllSurveysByUser({@required int pid}) async {
    Response<List<OpenapiSurvey>> response = await client.getDefaultApi().loadAllSurveysByUser(pid: pid);
    return response.data.map(_convertOpenapiSurveyToSurvey).toList();
  }

  Future<List<Survey>> loadAllSurveysExceptUser({@required int pid}) async {
    Response<List<OpenapiSurvey>> response = await client.getDefaultApi().loadAllSurveysExceptUser(pid: pid);
    return response.data.map(_convertOpenapiSurveyToSurvey).toList();
  }

  Future<Survey> createSurvey({@required Survey survey}) async {
    OpenapiSurvey openapiSurvey = OpenapiSurvey();
    OpenapiSurveyBuilder openapiSurveyBuilder = openapiSurvey.toBuilder();

    ListBuilder<OpenapiSurveyDetail> listBuilder = ListBuilder<OpenapiSurveyDetail>([]);
    listBuilder.addAll(survey.details.map(_convertSurveyDetailToOpenapiSurveyDetail).toList());

    openapiSurveyBuilder
      ..seid = survey.id
      ..title = survey.title
      ..descr = survey.description
      ..surveyDetails = listBuilder
      ..isOpen = survey.isOpen ? "1" : "0"
      ..customField03 = survey.userId;
    openapiSurvey = openapiSurveyBuilder.build();
    Response<List<OpenapiSurvey>> response = await client.getDefaultApi().createSurvey([openapiSurvey]);
    return _convertOpenapiSurveyToSurvey(response.data[0]);
  }

  Future<List<SurveyDetail>> getSurveyDetails({@required int seid}) async {
    Response<List<OpenapiSurveyDetail>> response = await client.getDefaultApi().getSurveyDetails(seid: seid);
    return response.data.map(_convertOpenapiSurveyDetailToSurveyDetail).toList();
  }

  Future deleteSurvey({@required int seid}) async {
    var response = await client.getDefaultApi().deleteSurvey(seid: seid);
    return response.data;
  }

  Future registerVote({@required int sdid, @required int pid}) async {
    OpenapiVote openapiVote = OpenapiVote();
    OpenapiVoteBuilder openapiVoteBuilder = openapiVote.toBuilder();
    openapiVoteBuilder
      ..sdid = sdid
      ..pid = pid;
    openapiVote = openapiVoteBuilder.build();
    var response = await client.getDefaultApi().insertActualVote([openapiVote]);
    return response.data;
  }
}

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:survey_client/model/openapi_survey.dart';
import 'package:survey_client/model/openapi_survey_detail.dart';
import 'package:survey_client/model/openapi_vote.dart';
import 'package:survey_client/model/openapi_vote_amount.dart';
import 'package:survey_client/model/openapi_vote_user.dart';
import 'package:surveys/logic/services/base_service.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/survey_vote_model.dart';
import 'package:surveys/models/vote_amount_model.dart';

class SurveyService extends BaseService {
  Survey _convertOpenapiSurveyToSurvey(OpenapiSurvey openapiSurvey) => Survey(
      id: openapiSurvey.seid,
      description: openapiSurvey.descr,
      isOpen: openapiSurvey.isOpen,
      title: openapiSurvey.title,
      userId: openapiSurvey.createdBy,
      details: openapiSurvey.surveyDetails?.map(_convertOpenapiSurveyDetailToSurveyDetail)?.toList());

  OpenapiSurveyDetail _convertSurveyDetailToOpenapiSurveyDetail(SurveyDetail surveyDetail) {
    OpenapiSurveyDetailBuilder openapiSurveyDetailBuilder = OpenapiSurveyDetailBuilder();
    openapiSurveyDetailBuilder
      ..sdid = surveyDetail.id
      ..seid = surveyDetail.surveyId
      ..descr = surveyDetail.description;

    return openapiSurveyDetailBuilder.build();
  }

  /*OpenapiVote _convertVoteToOpenapiVote(Vote vote) {
    OpenapiVoteBuilder openapiVoteBuilder = OpenapiVoteBuilder();
    openapiVoteBuilder
      ..avid = vote.id
      ..sdid = vote.surveyDetailId
      ..pid = vote.userId;
    return openapiVoteBuilder.build();
  }*/

  SurveyDetail _convertOpenapiSurveyDetailToSurveyDetail(OpenapiSurveyDetail openapiSurveyDetail) => SurveyDetail(
        id: openapiSurveyDetail.sdid,
        surveyId: openapiSurveyDetail.seid,
        description: openapiSurveyDetail.descr,
      );

  Future<List<Survey>> loadAllSurveysByUser({@required int pid}) async {
    Response<List<OpenapiSurvey>> response = await client.getDefaultApi().loadAllSurveysByUser(pid: pid);
    return response.data.map(_convertOpenapiSurveyToSurvey).toList();
  }

  Future<List<Survey>> loadAllSurveysExceptUser({@required int pid}) async {
    Response<List<OpenapiSurvey>> response = await client.getDefaultApi().loadAllSurveysExceptUser(pid: pid);
    return response.data.map(_convertOpenapiSurveyToSurvey).toList();
  }

  Future<Survey> createSurvey({@required Survey survey, @required creating}) async {
    OpenapiSurvey openapiSurvey = OpenapiSurvey();
    OpenapiSurveyBuilder openapiSurveyBuilder = openapiSurvey.toBuilder();

    ListBuilder<OpenapiSurveyDetail> listBuilder = ListBuilder<OpenapiSurveyDetail>([]);
    listBuilder.addAll(survey.details.map(_convertSurveyDetailToOpenapiSurveyDetail).toList());
    if (creating)
    {
      for (int i = 0; i < survey.details.length; i++)
        survey.details[i].id = null;
    }

    openapiSurveyBuilder
      ..seid = survey.id
      ..title = survey.title
      ..descr = survey.description
      ..surveyDetails = listBuilder
      ..isOpen = survey.isOpen
      ..createdBy = survey.userId;
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

  Future<List<int>> getUserSubmittedSurveys({@required int pid}) async {
    Response<List<int>> response = await client.getDefaultApi().getUserSubmittedSurveys(pid: pid);
    return response.data;
  }

  VoteAmount _convertOpenapiVoteAmountToVoteAmount(OpenapiVoteAmount openapiVoteAmount) => VoteAmount(
      amount: openapiVoteAmount.votes,
      vote: SurveyVote(id: null, surveyDetailId: openapiVoteAmount.sdid, surveyId: null));

  Future<List<VoteAmount>> getSurveyVotes({@required int seid}) async {
    try {
      Response<List<OpenapiVoteAmount>> response = await client.getDefaultApi().getActualVotes(seid: seid);
      return response.data.map(_convertOpenapiVoteAmountToVoteAmount).toList();
    } on Exception {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUserPreferences({@required int seid}) async {
    Response<List<OpenapiVoteUser>> response = await client.getDefaultApi().getActualPrincipalForVotes(seid: seid);
    return response.data.map((e) => {"user": e.user, "vote": e.sdid}).toList();
  }
}

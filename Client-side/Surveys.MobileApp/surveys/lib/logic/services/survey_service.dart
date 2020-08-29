import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:survey_client/model/openapi_survey.dart';
import 'package:surveys/logic/services/base_service.dart';
import 'package:surveys/models/survey_model.dart';

class SurveyService extends BaseService {
  Survey _convertOpenapiSurveyToSurvey(OpenapiSurvey openapiSurvey) => Survey(
        id: openapiSurvey.seid,
        description: openapiSurvey.descr,
        isOpen: openapiSurvey.isOpen == "1",
        title: openapiSurvey.title,
      );

  Future<List<Survey>> loadAllSurveysByUser({@required int pid}) async {
    Response<List<OpenapiSurvey>> response = await client.getDefaultApi().loadAllSurveysByUser(pid: pid);
    return response.data.map(_convertOpenapiSurveyToSurvey).toList();
  }
}

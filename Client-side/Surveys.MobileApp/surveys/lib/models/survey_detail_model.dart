import 'package:flutter/cupertino.dart';

class SurveyDetail {
  final int id;
  final int surveyId;
  String description;
  String customField01;
  String customField02;
  String customField03;

  SurveyDetail(
      {@required this.id,
      @required this.surveyId,
      this.description,
      this.customField01,
      this.customField02,
      this.customField03});
}

import 'package:flutter/cupertino.dart';

class SurveyDetail {
  int id;
  final int surveyId;
  String description;

  SurveyDetail({
    @required this.id,
    @required this.surveyId,
    this.description,
  });
}

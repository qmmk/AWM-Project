import 'package:flutter/cupertino.dart';

class SurveyVote {
  final int id;
  final int surveyId;
  final int surveyDetailId;
  final DateTime registeredOn;

  SurveyVote(
      {@required this.id,
      @required this.surveyId,
      @required this.surveyDetailId,
      this.registeredOn});
}

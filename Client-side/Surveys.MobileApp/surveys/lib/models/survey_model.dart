import 'package:flutter/cupertino.dart';
import 'package:surveys/models/survey_details_model.dart';

class Survey {
  final int id;
  String title; //
  String description; //
  bool isOpen; //
  List<SurveyDetail> details;
  String customField01;
  String customField03;

  Survey(
      {@required this.id,
      this.title,
      this.description,
      this.isOpen,
      this.details});
}

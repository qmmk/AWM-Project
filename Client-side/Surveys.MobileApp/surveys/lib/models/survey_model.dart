import 'package:flutter/cupertino.dart';
import 'package:surveys/models/survey_detail_model.dart';

class Survey {
  final int id;
  String title; //
  String description; //
  bool isOpen; //
  List<SurveyDetail> details;
  String customField01;
  String customField03; //should be pid

  Survey({@required this.id, this.title, this.description, this.isOpen, this.details, this.customField03});
}

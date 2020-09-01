import 'package:flutter/cupertino.dart';
import 'package:surveys/models/survey_detail_model.dart';

class Survey {
  final int id;
  String title; //
  String description; //
  bool isOpen; //
  List<SurveyDetail> details;
  String customField01;
  String pid; //should be CustomField03 in requests

  Survey({@required this.id, this.title, this.description, this.isOpen, this.details, this.pid});
}

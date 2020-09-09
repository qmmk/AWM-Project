import 'package:flutter/cupertino.dart';
import 'package:surveys/models/survey_detail_model.dart';

class Survey {
  final int id;
  String title;
  String description;
  bool isOpen;
  List<SurveyDetail> details;
  int userId; 

  Survey({@required this.id, this.title, this.description, this.isOpen, this.details, this.userId});
}

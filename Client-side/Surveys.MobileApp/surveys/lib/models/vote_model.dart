import 'package:flutter/cupertino.dart';

class Vote {
  final int id;
  final int userId;
  final int surveyDetailId;
  final DateTime registeredOn;
  final String customField01;
  final String customField02;
  final String customField03;

  Vote(
      {this.id,
      @required this.userId,
      @required this.surveyDetailId,
      this.registeredOn,
      this.customField01,
      this.customField02,
      this.customField03});
}

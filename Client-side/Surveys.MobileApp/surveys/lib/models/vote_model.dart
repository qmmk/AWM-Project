import 'package:flutter/cupertino.dart';

class Vote {
  final int id;
  final int userId;
  final int surveyDetailId;
  final DateTime registeredOn;

  Vote({
    this.id,
    @required this.userId,
    @required this.surveyDetailId,
    this.registeredOn,
  });
}

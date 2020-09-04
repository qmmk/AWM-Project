import 'package:flutter/cupertino.dart';
import 'package:surveys/models/survey_vote_model.dart';

class VoteAmount {
  final SurveyVote vote;
  final int amount;

  VoteAmount({@required this.vote, @required this.amount});
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/user_model.dart';
import 'package:surveys/models/vote_model.dart';

final String userKey = "user";
final String voteKey = "vote";

class SurveyResultsVotePage extends StatefulWidget {
  final List<Map<String, dynamic>> preferences; //User - SurveyDetail couples
  final Survey survey;

  SurveyResultsVotePage({Key key, @required this.preferences, @required this.survey}) : super(key: key);

  @override
  _SurveyResultsVotePageState createState() => _SurveyResultsVotePageState();
}

class _SurveyResultsVotePageState extends State<SurveyResultsVotePage> {
  @override
  void initState() {
    //assert(!widget.preferences.any((element) => element[userKey] is! User || element[voteKey] is! Vote));
    /*_fakeVotes = List.generate(
        20,
        (index) => {
              "user": User(id: index, username: "pincopallo$index"),
              "vote": Vote(
                userId: index,
                surveyDetailId: Random().nextInt(5),
              )
            });*/
    super.initState();
  }

  String _getDetailName(int sdid) => widget.survey.details.singleWhere((element) => element.id == sdid).description;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: Colors.transparent,
          transitionBetweenRoutes: false,
          previousPageTitle: "Survey",
        ),
        child: SafeArea(
          child: ListView.separated(
              padding: EdgeInsets.only(top: 15),
              itemBuilder: (context, index) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 30,
                          child: Icon(
                            CupertinoIcons.person_solid,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(style: TextStyle(fontSize: 16, color: Colors.black), children: [
                            TextSpan(
                                text: "${widget.preferences[index]["user"].trim()}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " voted for "),
                            TextSpan(
                                text: "${_getDetailName(widget.preferences[index]["vote"]).trim()}",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ]),
                        )
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: widget.preferences?.length ?? 0),
        ));
  }
}

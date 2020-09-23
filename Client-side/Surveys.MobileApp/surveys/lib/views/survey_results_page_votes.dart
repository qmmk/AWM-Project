import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/models/user_model.dart';
import 'package:surveys/models/vote_model.dart';

class SurveyResultsVotePage extends StatefulWidget {
  final List<Map<String, dynamic>> voteCouples; //User - SurveyDetail couples

  SurveyResultsVotePage({Key key, this.voteCouples}) : super(key: key);

  @override
  _SurveyResultsVotePageState createState() => _SurveyResultsVotePageState();
}

class _SurveyResultsVotePageState extends State<SurveyResultsVotePage> {
  final String userKey = "user";
  final String voteKey = "vote";

  List<Map<String, dynamic>> _fakeVotes;

  @override
  void initState() {
    //assert(!widget.voteCouples.any((element) => element[userKey] is! User || element[voteKey] is! Vote));
    _fakeVotes = List.generate(
        20,
        (index) => {
              "user": User(id: index, username: "pincopallo$index"),
              "vote": Vote(
                userId: index,
                surveyDetailId: Random().nextInt(5),
              )
            });
    super.initState();
  }

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
              padding: EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => Row(
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
                              text: "${_fakeVotes[index]["user"].username}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: " voted for "),
                          TextSpan(
                              text: "${_fakeVotes[index]["vote"].surveyDetailId}",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]),
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: _fakeVotes.length),
        ));
  }
}

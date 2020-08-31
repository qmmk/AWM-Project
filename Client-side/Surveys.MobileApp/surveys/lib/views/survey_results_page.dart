import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/survey_vote_model.dart';

class SurveyResultsPage extends StatefulWidget {
  final Survey survey;

  SurveyResultsPage({Key key, @required this.survey}) : super(key: key);

  @override
  _SurveyResultsPageState createState() => _SurveyResultsPageState();
}

class _SurveyResultsPageState extends State<SurveyResultsPage> {
  List<SurveyVote> _votes;
  bool _notAccessible = false;
  bool _noEntries = false;

  @override
  void initState() {
    super.initState();
    _noEntries = (widget?.survey?.details?.length ?? 0) <= 0;
    _notAccessible = !widget.survey.isOpen;

    if (_notAccessible || _noEntries) return;
    _votes = _generateRandomVotes();
  }

  List<SurveyVote> _generateRandomVotes() {
    Random random = Random();

    return List.generate(200, (index) {
      SurveyDetail picked = widget.survey.details[random.nextInt(widget.survey.details.length)];
      return SurveyVote(id: index, surveyId: picked.surveyId, surveyDetailId: picked.id);
    });
  }

  double calculateEntryPercentage({@required int voteId}) {
    return _votes.where((element) => element.surveyDetailId == voteId).length / _votes.length;
  }

  Widget _content() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          double perc = calculateEntryPercentage(voteId: widget.survey.details[index].id);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.survey.details[index].description), Text((perc * 100).toStringAsFixed(1) + "%")],
              ),
              LinearProgressIndicator(
                value: perc,
              )
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
        itemCount: widget.survey.details.length);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: Colors.transparent,
          transitionBetweenRoutes: false,
          middle: Text(widget.survey.title),
        ),
        child: _notAccessible || _noEntries
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.flag,
                      size: 70,
                    ),
                    Text(_noEntries
                        ? "Sorry, there are no entries for this survey!"
                        : "Sorry, this survey hasn't already been opened!")
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: _content(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          "Survey's description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          widget.survey.description,
                          style: TextStyle(color: CupertinoColors.systemGrey),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}

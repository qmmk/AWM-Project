import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/collection_provider.dart';
import 'package:surveys/logic/services/survey_service.dart';
import 'package:surveys/logic/utils/menu_utils.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/models/survey_vote_model.dart';
import 'package:surveys/models/vote_amount_model.dart';

class SurveyResultsPage extends StatefulWidget {
  final Survey survey;
  final List<VoteAmount> votes;
  final bool isPersonal;

  SurveyResultsPage({Key key, @required this.survey, @required this.votes, @required this.isPersonal})
      : super(key: key);

  @override
  _SurveyResultsPageState createState() => _SurveyResultsPageState();
}

class _SurveyResultsPageState extends State<SurveyResultsPage> with SingleTickerProviderStateMixin {
  final Duration updateInterval = Duration(seconds: 3);

  bool _notAccessible = false;
  bool _noEntries = false;
  List<VoteAmount> _votes;

  bool _isPolling = true;
  Timer _pollingTimer;

  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  AnimationController _animationController;

  bool _isLoadingVotes = false;

  bool get resultsAvailable => !_notAccessible && !_noEntries;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _noEntries = (widget?.survey?.details?.length ?? 0) <= 0;
    _notAccessible = !widget.survey.isOpen;
    _votes = widget.votes;

    if (resultsAvailable) _startPollingVotes();
  }

  void _startPollingVotes() {
    _pollingTimer = Timer.periodic(updateInterval, (timer) async {
      await _refreshVotes();
    });
    _animationController.reverse();
  }

  void _stopPollingVotes() {
    _pollingTimer.cancel();
    _animationController.forward();
  }

  double calculateEntryPercentage({@required int detailId}) {
    int votesForEntry = _votes
        .singleWhere((element) => element.vote.surveyDetailId == detailId,
            orElse: () => VoteAmount(amount: 0, vote: SurveyVote(surveyDetailId: detailId, id: null, surveyId: null)))
        .amount;
    int totalVotes = 0;
    _votes.forEach((element) {
      totalVotes += element.amount;
    });
    return totalVotes == 0 ? 0 : votesForEntry / totalVotes;
  }

  Widget _entries() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          double perc = calculateEntryPercentage(detailId: widget.survey.details[index].id);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.survey.details[index].description), Text("${(perc * 100).toStringAsFixed(1)}%")],
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

  Future<void> _refreshVotes() async {
    if (context == null) return;

    CollectionProvider provider = Provider.of<CollectionProvider>(context, listen: false);
    int index = (widget.isPersonal ? provider.userSurveys : provider.othersSurveys)
        .indexWhere((element) => element.id == widget.survey.id);
    List<VoteAmount> newVotes = await provider.getSurveyVotes(index: index, isPersonal: widget.isPersonal);
    if (newVotes != null) {
      setState(() {
        _votes = newVotes;
        _refreshController.refreshCompleted();
      });
    } else
      MenuUtils.showErrorDialog(context: context, title: "Couldn't refresh votes");
  }

  Widget _content() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _entries(),
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
              ),
              Center(
                child: CupertinoButton(
                  onPressed: () async {
                    setState(() {
                      _isLoadingVotes = true;
                    });

                    List<Map<String, dynamic>> preferences =
                        await SurveyService().getUserPreferences(seid: widget.survey.id);

                    setState(() {
                      _isLoadingVotes = false;
                    });

                    Navigator.of(context).pushNamed(Routes.surveyResultsVotes,
                        arguments: {"preferences": preferences, "survey": widget.survey});
                  },
                  child: Text("Show votes"),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _wholeContent() => _notAccessible || _noEntries
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
      : SafeArea(
          child: !_isPolling
              ? SmartRefresher(
                  onRefresh: () async {
                    await _refreshVotes();
                  },
                  controller: _refreshController,
                  child: _content(),
                )
              : _content(),
        );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: Colors.transparent,
          transitionBetweenRoutes: false,
          middle: Text(widget.survey.title),
          trailing: resultsAvailable
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_isPolling)
                        _stopPollingVotes();
                      else
                        _startPollingVotes();
                      _isPolling = !_isPolling;
                    });
                  },
                  child: AnimatedIcon(
                    color: CupertinoColors.activeBlue,
                    icon: AnimatedIcons.pause_play,
                    progress: _animationController,
                  ))
              : null,
        ),
        child: _isLoadingVotes
            ? Stack(
                children: [
                  Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  Opacity(
                    opacity: 0.25,
                    child: _wholeContent(),
                  )
                ],
              )
            : _wholeContent());
  }
}

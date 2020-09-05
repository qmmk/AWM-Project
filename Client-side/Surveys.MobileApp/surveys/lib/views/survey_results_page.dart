import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
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

class _SurveyResultsPageState extends State<SurveyResultsPage> {
  bool _notAccessible = false;
  bool _noEntries = false;
  List<VoteAmount> _votes;

  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    _noEntries = (widget?.survey?.details?.length ?? 0) <= 0;
    _notAccessible = !widget.survey.isOpen;
    _votes = widget.votes;

    if (_notAccessible || _noEntries) return;
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
    return votesForEntry / totalVotes;
  }

  Widget _content() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          double perc = calculateEntryPercentage(detailId: widget.survey.details[index].id);

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
            : SafeArea(
                child: SmartRefresher(
                  onRefresh: () async {
                    UserAndCollectionProvider provider = Provider.of<UserAndCollectionProvider>(context, listen: false);
                    int index = (widget.isPersonal ? provider.userSurveys : provider.othersSurveys)
                        .indexWhere((element) => element.id == widget.survey.id);
                    List<VoteAmount> newVotes =
                        await provider.getSurveyVotes(index: index, isPersonal: widget.isPersonal);
                    setState(() {
                      _votes = newVotes;
                      _refreshController.refreshCompleted();
                    });
                  },
                  controller: _refreshController,
                  child: Padding(
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
                  ),
                ),
              ));
  }
}

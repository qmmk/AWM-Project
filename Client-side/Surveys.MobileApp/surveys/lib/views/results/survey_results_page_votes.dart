import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';

final String userKey = "user";
final String voteKey = "vote";

class SurveyResultsVotePage extends StatefulWidget {
  final List<Map<String, dynamic>> preferences; //User - SurveyDetail couples
  final Survey survey;

  SurveyResultsVotePage({Key key, @required this.preferences, @required this.survey}) : super(key: key);

  @override
  _SurveyResultsVotePageState createState() => _SurveyResultsVotePageState();
}

class _SurveyResultsVotePageState extends State<SurveyResultsVotePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.survey.details.length, vsync: this);
    super.initState();
  }

  List<Tab> _tabs() => widget.survey.details.map((e) {
        List<Map<String, dynamic>> preferences =
            widget.preferences.where((element) => element["vote"] == e.id).toList();

        return Tab(
          child: Text(
            "${e.description} (${preferences.length})",
            style: TextStyle(color: CupertinoColors.black),
          ),
        );
      }).toList();

  Widget _currentTab() {
    SurveyDetail selectedDetail = widget.survey.details[_tabController.index];
    List<Map<String, dynamic>> preferences =
        widget.preferences.where((element) => element["vote"] == selectedDetail.id).toList();

    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 15),
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
                Text(
                  "${preferences[index]["user"].trim()}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: CupertinoColors.black),
                ),
              ],
            ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: preferences?.length ?? 0);
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
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: _tabs(),
                  onTap: (newIndex) {
                    setState(() {});
                  },
                ),
                _currentTab()
              ],
            ),
          ),
        ));
  }
}

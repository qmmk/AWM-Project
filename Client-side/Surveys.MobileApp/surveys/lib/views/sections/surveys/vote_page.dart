import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/models/survey_model.dart';

class VotePage extends StatefulWidget {
  final Survey survey;

  VotePage({Key key, @required this.survey}) : super(key: key);

  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  int _chosenIndex = -1;
  bool _notAccessible = false;
  bool _noEntries = false;

  @override
  void initState() {
    super.initState();
    _noEntries = (widget?.survey?.details?.length ?? 0) <= 0;
    _notAccessible = !widget.survey.isOpen;
  }

  Widget _content() {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Material(
                child: Checkbox(
                  value: _chosenIndex == index,
                  onChanged: (active) {
                    setState(() {
                      if (active)
                        _chosenIndex = index;
                      else if (_chosenIndex == index) _chosenIndex = -1;
                    });
                  },
                ),
              ),
              Text(widget.survey.details[index].description)
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: 5,
            ),
        itemCount: widget.survey.details.length);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: CupertinoColors.white,
          transitionBetweenRoutes: false,
          middle: Text(widget.survey.title),
          trailing: _notAccessible || _noEntries
              ? Container()
              : GestureDetector(
                  child: Icon(
                  CupertinoIcons.check_mark,
                  size: 43,
                )),
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
            : Column(
                children: [
                  _content(),
                ],
              ));
  }
}

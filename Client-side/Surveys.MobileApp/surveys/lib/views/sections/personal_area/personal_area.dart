import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/views/widgets/survey_entry.dart';

class PersonalAreaPage extends StatefulWidget {
  PersonalAreaPage({Key key}) : super(key: key);

  @override
  _PersonalAreaPageState createState() => _PersonalAreaPageState();
}

class _PersonalAreaPageState extends State<PersonalAreaPage> {
  List<Survey> _surveys;

  @override
  void initState() {
    super.initState();
    _surveys = List.generate(
        15,
        (index) => Survey(
            id: 0,
            title: "Survey #${index + 1}",
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vel neque ac turpis euismod elementum. Vestibulum gravida nisi venenatis dignissim vehicula. Nunc commodo eleifend nisi vitae volutpat. Donec nec felis quis ante tincidunt maximus at ac sem. Praesent efficitur, nunc id iaculis sodales, tellus purus bibendum est, sed tincidunt orci est quis arcu. Pellentesque non ante eget ex fermentum porta ac vitae tortor. Maecenas velit augue, laoreet pretium elit eget, lobortis varius massa. Mauris fermentum ex et augue pretium cursus. Suspendisse ornare ultricies pharetra. Suspendisse nec elit eu tortor placerat tincidunt. Phasellus dapibus sed purus ut malesuada. Vivamus feugiat in nibh quis commodo. Cras a suscipit nibh.",
            isOpen: Random().nextBool(),
            details: List.generate(4, (index) => SurveyDetail(id: index, surveyId: -1, description: "Entry $index"))));
  }

  Widget _surveyElement(int index) => Card(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.of(context).pushNamed(Routes.surveyResults, arguments: {"survey": _surveys[index]});
          },
          onLongPress: () {
            Navigator.of(context).pushNamed(Routes.createSurvey, arguments: {"survey": _surveys[index]}).then((survey) {
              if (survey != null)
                setState(() {
                  _surveys[index] = survey;
                });
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SurveyEntryWidget(survey: _surveys[index]),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text("My surveys"),
          border: null,
          trailing: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.accountSettings);
            },
            behavior: HitTestBehavior.translucent,
            child: Icon(CupertinoIcons.settings),
          ),
        ),
        child: ListView.separated(
            itemBuilder: (context, index) => _surveyElement(index),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: _surveys.length));
  }
}

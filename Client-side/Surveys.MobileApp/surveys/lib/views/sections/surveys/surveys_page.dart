import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/models/survey_model.dart';
import 'package:surveys/views/widgets/survey_entry.dart';

class SurveysPage extends StatefulWidget {
  SurveysPage({Key key}) : super(key: key);

  @override
  _SurveysPageState createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> {
  List<Survey> _surveys;

  @override
  void initState() {
    super.initState();
    _surveys = List.generate(
        15,
        (index) => Survey(
            id: 0,
            title: "Elezioni presidenziali 2020",
            description:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque vel neque ac turpis euismod elementum. Vestibulum gravida nisi venenatis dignissim vehicula. Nunc commodo eleifend nisi vitae volutpat. Donec nec felis quis ante tincidunt maximus at ac sem. Praesent efficitur, nunc id iaculis sodales, tellus purus bibendum est, sed tincidunt orci est quis arcu. Pellentesque non ante eget ex fermentum porta ac vitae tortor. Maecenas velit augue, laoreet pretium elit eget, lobortis varius massa. Mauris fermentum ex et augue pretium cursus. Suspendisse ornare ultricies pharetra. Suspendisse nec elit eu tortor placerat tincidunt. Phasellus dapibus sed purus ut malesuada. Vivamus feugiat in nibh quis commodo. Cras a suscipit nibh.",
            isOpen: Random().nextBool(),
            details: []));
  }

  Widget _surveyElement(Survey survey) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SurveyEntryWidget(survey: survey),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text("Explore surveys"),
          border: null,
        ),
        child: ListView.separated(
            itemBuilder: (context, index) => _surveyElement(_surveys[index]),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
            itemCount: _surveys.length));
  }
}

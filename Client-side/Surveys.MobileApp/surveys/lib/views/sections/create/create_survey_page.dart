import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';

class CreateSurveyPage extends StatefulWidget {
  CreateSurveyPage({Key key}) : super(key: key);

  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  Survey _survey;
  bool _open;

  @override
  void initState() {
    _survey = Survey(id: -1, details: [
      SurveyDetail(id: 0, surveyId: -1, description: "John Biden"),
      SurveyDetail(id: 1, surveyId: -1, description: "Donald Trump")
    ]);
    _open = false;
    super.initState();
  }

  Widget _entryList() => ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.createSurveyEntry,
                  arguments: {
                    "surveyDetail": _survey.details[index]
                  }).then((value) {
                setState(() {
                  if (value != null) _survey.details[index].description = value;
                });
              });
            },
            child: Dismissible(
                onDismissed: (direction) {
                  setState(() {
                    _survey.details.removeAt(index);
                  });
                },
                key: Key(index.toString()),
                child: Container(
                    child: Text(_survey?.details[index].description))),
          ),
      separatorBuilder: (context, index) => SizedBox(
            height: 5,
          ),
      itemCount: _survey?.details?.length ?? 0);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text("Create a survey"),
          border: null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: CupertinoTextField(
                            placeholder: "Title",
                          ),
                        ),
                        CupertinoTextField(
                          placeholder: "Description",
                          minLines: 2,
                          maxLines: 10,
                        ),
                        if (_survey?.details != null) _entryList(),
                        CupertinoButton(
                            child: Text("Add entry",),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.createSurveyEntry)
                                  .then((value) {
                                if (value != null)
                                  setState(() {
                                    _survey.details.add(SurveyDetail(
                                        id: 0,
                                        surveyId: -1,
                                        description: value));
                                  });
                              });
                            }),
                        Row(
                          children: [
                            CupertinoSwitch(
                                value: _open,
                                onChanged: (value) {
                                  setState(() {
                                    _open = value;
                                  });
                                }),
                            Text("Open")
                          ],
                        )
                      ],
                    ),
                    CupertinoButton.filled(
                        child: Text("Confirm"), onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

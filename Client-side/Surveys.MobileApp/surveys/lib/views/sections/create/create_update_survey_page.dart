import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_provider.dart';
import 'package:surveys/models/survey_detail_model.dart';
import 'package:surveys/models/survey_model.dart';

class CreateSurveyPage extends StatefulWidget {
  final Survey survey;

  CreateSurveyPage({Key key, this.survey}) : super(key: key);

  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  Survey _survey;
  bool _open;
  bool _isModifying;

  TextEditingController _titleController = TextEditingController(text: "title");
  TextEditingController _descriptionController = TextEditingController(text: "description");
  GlobalKey<FormState> _formKey = GlobalKey();

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(
                "Logout failed",
                style: TextStyle(color: Colors.red),
              ),
              content: Text("Please try again later"),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                )
              ],
            ));
  }

  @override
  void initState() {
    _isModifying = widget.survey != null;
    if (_isModifying) {
      _survey = widget.survey;
      if (_survey.details == null) _survey.details = [];
      _titleController.text = _survey.title;
      _descriptionController.text = _survey.description;
      _open = _survey.isOpen;
    } else {
      _titleController.text = "";
      _descriptionController.text = "";
      _survey = Survey(id: -1, details: [
        SurveyDetail(id: 0, surveyId: -1, description: "John Biden"),
        SurveyDetail(id: 1, surveyId: -1, description: "Donald Trump"),
        SurveyDetail(id: 2, surveyId: -1, description: "John Biden"),
        SurveyDetail(id: 3, surveyId: -1, description: "Donald Trump"),
        SurveyDetail(id: 4, surveyId: -1, description: "John Biden"),
        SurveyDetail(id: 5, surveyId: -1, description: "Donald Trump"),
        SurveyDetail(id: 6, surveyId: -1, description: "John Biden"),
        SurveyDetail(id: 7, surveyId: -1, description: "Donald Trump")
      ]);
      _open = false;
    }
    super.initState();
  }

  Widget _entryList() => SizedBox(
        height: 100,
        child: ListView.separated(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.createSurveyEntry,
                        arguments: {"surveyDetail": _survey.details[index]}).then((value) {
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
                      key: Key(_survey.details[index].id.toString()),
                      child: Container(child: Text(_survey?.details[index].description))),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
            itemCount: _survey?.details?.length ?? 0),
      );

  Widget _content() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Material(
                    child: TextFormField(
                      controller: _titleController,
                      validator: (s) {
                        if (s.trim().isEmpty) return "Please enter the survey's name";

                        return null;
                      },
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                  ),
                ),
                Material(
                  child: TextFormField(
                    minLines: 3,
                    maxLines: 3,
                    controller: _descriptionController,
                    decoration: InputDecoration(hintText: "Enter the survey's description"),
                  ),
                ),
                if (_survey?.details != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: _entryList(),
                  ),
                CupertinoButton(
                    child: Text(
                      "Add entry",
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.createSurveyEntry).then((value) {
                        if (value != null)
                          setState(() {
                            _survey.details.add(SurveyDetail(id: 0, surveyId: -1, description: value));
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
          ),
          /*CupertinoButton.filled(
              child: Text("Confirm"),
              onPressed: () {
                _survey
                  ..title = _titleController.text
                  ..description = _descriptionController.text
                  ..isOpen = _open;
                if (_isModifying) Navigator.of(context).pop(_survey);
              }),*/
        ],
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: widget.survey != null ? Text("Update survey") : Text("Create a survey"),
          border: null,
          trailing: GestureDetector(
              onTap: () async {
                if (!_formKey.currentState.validate()) return;

                _survey
                  ..title = _titleController.text
                  ..description = _descriptionController.text
                  ..isOpen = _open;

                if (!_isModifying) {
                  bool success = await Provider.of<UserProvider>(context, listen: false).createSurvey(survey: _survey);
                  if (!success) {
                    _showErrorDialog();
                    return;
                  }

                  _titleController.text = "";
                  _descriptionController.text = "";
                  FocusScope.of(context).requestFocus(FocusNode());
                }

                if (_isModifying) Navigator.of(context).pop(_survey);
              },
              child: Icon(
                CupertinoIcons.check_mark,
                size: 43,
              )),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: widget.survey != null
              ? _content()
              : SingleChildScrollView(
                  child: Container(height: MediaQuery.of(context).size.height, child: _content()),
                ),
        ));
  }
}

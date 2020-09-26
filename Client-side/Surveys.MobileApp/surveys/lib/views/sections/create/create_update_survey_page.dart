import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/constants/surveys_constants.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/logic/utils/menu_utils.dart';
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

  bool _isWaitingForServer = false;

  @override
  void initState() {
    _isModifying = widget.survey != null;
    if (_isModifying) {
      _survey = Survey(
          id: widget.survey.id,
          description: widget.survey.description,
          details: List.from(widget.survey.details),
          isOpen: widget.survey.isOpen,
          title: widget.survey.title,
          userId: widget.survey.userId);

      if (_survey.details == null) _survey.details = [];
      _titleController.text = _survey.title;
      _descriptionController.text = _survey.description;
      _open = _survey.isOpen;
    } else {
      _titleController.text = "";
      _descriptionController.text = "";
      _survey = Survey(id: -1, details: []);
      _open = false;
    }
    super.initState();
  }

  bool _hasModifiedEntries() => !DeepCollectionEquality().equals(_survey.details, widget.survey.details);

  Widget _entryList() => SizedBox(
        height: 150,
        child: ListView.separated(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.createSurveyEntry,
                        arguments: {"surveyDetail": _survey.details[index]}).then((surveyDetail) {
                      setState(() {
                        if (surveyDetail != null) _survey.details[index] = surveyDetail;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 10 : 0, left: 10, right: 10),
                    child: Dismissible(
                        onDismissed: (direction) {
                          setState(() {
                            _survey.details.removeAt(index);
                          });
                        },
                        key: Key(_survey.details[index].id.toString()),
                        child: Container(child: Text(_survey?.details[index].description))),
                  ),
                ),
            separatorBuilder: (context, index) => Divider(),
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
                    color: Colors.transparent,
                    child: TextFormField(
                      controller: _titleController,
                      validator: (s) {
                        if (s.trim().isEmpty) return "Please enter the survey's title";
                        if (s.trim().length > SurveysConstants.surveyTitleLimit)
                          return "Surveys' title limit is ${SurveysConstants.surveyTitleLimit} characters";

                        return null;
                      },
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: TextFormField(
                    validator: (s) {
                      if (s.trim().length > SurveysConstants.surveyDescriptionLimit)
                        return "Surveys' description limit is ${SurveysConstants.surveyDescriptionLimit} characters";

                      return null;
                    },
                    minLines: 3,
                    maxLines: 3,
                    controller: _descriptionController,
                    decoration: InputDecoration(hintText: "Enter the survey's description"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Preferences",
                    style: TextStyle(color: CupertinoColors.systemBlue, fontSize: 13),
                  ),
                ),
                if (_survey?.details != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color:
                                    _atLeastTwoEntriesError ? CupertinoColors.systemRed : CupertinoColors.systemBlue)),
                        child: _entryList()),
                  ),
                Visibility(
                  visible: _atLeastTwoEntriesError,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "Please enter at least 2 preferences",
                      style: TextStyle(color: CupertinoColors.systemRed, fontSize: 13),
                    ),
                  ),
                ),
                CupertinoButton(
                    child: Text(
                      "Add entry",
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.createSurveyEntry).then((surveyDetail) {
                        if (surveyDetail != null)
                          setState(() {
                            int id = (_survey.details?.length ?? 0) == 0
                                ? 0
                                : ((_isModifying ? widget.survey : _survey)
                                        .details
                                        .map((e) => e.id)
                                        .toList()
                                        .reduce(max)) +
                                    1; // Use the original survey in order not to use an already-used id

                            _survey.details.add(SurveyDetail(
                                id: id,
                                surveyId: widget.survey == null ? -1 : widget.survey.id,
                                description: (surveyDetail as SurveyDetail).description));
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
        ],
      );

  bool _atLeastTwoEntriesError = false;

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool error = false;

    if (!_formKey.currentState.validate()) error = true;
    if (_survey.details.length < 2) {
      setState(() {
        _atLeastTwoEntriesError = true;
      });
      error = true;
    }

    if (error) return;

    setState(() {
      _atLeastTwoEntriesError = false;
      _isWaitingForServer = true;
    });

    _survey
      ..title = _titleController.text
      ..description = _descriptionController.text
      ..isOpen = _open;

    if (_isModifying) {
      Navigator.of(context).pop(_survey);
      setState(() {
        _isWaitingForServer = false;
      });
      return;
    }

    UserAndCollectionProvider userProvider = Provider.of<UserAndCollectionProvider>(context, listen: false);
    bool success = await userProvider.createSurvey(survey: _survey);
    if (success) {
      setState(() {
        _titleController.text = "";
        _descriptionController.text = "";
        _survey.details = [];
      });

      await MenuUtils.showAlertDialog(context: context, title: "Survey successfully created!");
    } else
      MenuUtils.showErrorDialog(context: context, title: "Couldn't create the survey");

    setState(() {
      _isWaitingForServer = false;
    });
  }

  Widget _contentDueToBug() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: widget.survey != null
            ? _content()
            : SingleChildScrollView(
                child: Container(height: MediaQuery.of(context).size.height, child: _content()),
              ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          backgroundColor: Colors.transparent,
          middle: widget.survey != null ? Text("Update survey") : Text("Create a survey"),
          border: null,
          trailing: GestureDetector(
              onTap: () {
                if (_isModifying && _hasModifiedEntries()) {
                  MenuUtils.showConfirmationDialog(
                          context: context,
                          title: "Are you sure to modify this survey?",
                          subtitle: "All the votes for the removed or modified entries will be deleted")
                      .then((yes) async {
                    if (yes) {
                      _submit();
                    }
                  });
                } else
                  _submit();
              },
              child: Icon(
                CupertinoIcons.check_mark,
                size: 43,
              )),
        ),
        child: _isWaitingForServer
            ? Stack(
                children: [
                  Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  Opacity(
                    opacity: 0.25,
                    child: _contentDueToBug(),
                  )
                ],
              )
            : _contentDueToBug());
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/models/survey_detail_model.dart';

class CreateEntryPage extends StatefulWidget {
  final SurveyDetail surveyDetail;
  CreateEntryPage({Key key, this.surveyDetail}) : super(key: key);

  @override
  _CreateEntryPageState createState() => _CreateEntryPageState();
}

class _CreateEntryPageState extends State<CreateEntryPage> {
  SurveyDetail _surveyDetail;
  TextEditingController _descriptionController;

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _surveyDetail = widget.surveyDetail ?? SurveyDetail(id: null, surveyId: null);
    _descriptionController = widget.surveyDetail == null
        ? TextEditingController()
        : TextEditingController(text: widget.surveyDetail.description);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          backgroundColor: Colors.transparent,
          middle: widget.surveyDetail != null ? Text("Update entry") : Text("Create an entry"),
          border: null,
          trailing: GestureDetector(
            onTap: () {
              if (!_formKey.currentState.validate()) return;

              _surveyDetail.description = _descriptionController.text;

              Navigator.of(context).pop(_surveyDetail);
            },
            child: Icon(
              CupertinoIcons.check_mark,
              size: 43,
            ),
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 30, top: 10),
              child: Material(
                child: TextFormField(
                  validator: (s) {
                    if (s.trim().isEmpty) return "Please give a description to the entry";
                    return null;
                  },
                  controller: _descriptionController,
                  decoration: InputDecoration(hintText: "Enter the entry's description"),
                  minLines: 2,
                  maxLines: 10,
                ),
              ),
            ),
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:surveys/models/survey_detail_model.dart';

class CreateEntryPage extends StatefulWidget {
  final SurveyDetail surveyDetail;
  CreateEntryPage({Key key, this.surveyDetail}) : super(key: key);

  @override
  _CreateEntryPageState createState() => _CreateEntryPageState();
}

class _CreateEntryPageState extends State<CreateEntryPage> {
  SurveyDetail _surveyDetail;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _surveyDetail = widget.surveyDetail ?? SurveyDetail(id: 0, surveyId: -1);
    _controller = widget.surveyDetail == null
        ? TextEditingController()
        : TextEditingController(text: widget.surveyDetail.description);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoNavigationBarBackButton(),
              Text("Add an entry to the survey"),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop(_controller.text.trim().isNotEmpty ? _controller.text.trim() : null);
                },
                child: Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  size: 40,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 30, top: 10),
            child: CupertinoTextField(
              controller: _controller,
              placeholder: "Description",
              minLines: 2,
              maxLines: 10,
            ),
          )
        ],
      ),
    ));
  }
}

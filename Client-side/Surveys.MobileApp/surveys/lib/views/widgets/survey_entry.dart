import 'package:flutter/cupertino.dart';
import 'package:surveys/models/survey_model.dart';

class SurveyEntryWidget extends StatelessWidget {
  final Survey survey;

  const SurveyEntryWidget({Key key, @required this.survey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  survey.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                if (survey.description != null && survey.description.trim().isNotEmpty)
                  Text(
                    survey.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: CupertinoColors.systemGrey),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              CupertinoIcons.circle_filled,
              color: survey.isOpen ? CupertinoColors.activeGreen : CupertinoColors.systemRed,
            ),
          )
        ],
      ),
    );
  }
}

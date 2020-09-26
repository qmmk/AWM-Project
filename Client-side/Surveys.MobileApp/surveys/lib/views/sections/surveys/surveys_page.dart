import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/logic/utils/client_events_stream.dart';
import 'package:surveys/logic/utils/menu_utils.dart';
import 'package:surveys/models/vote_amount_model.dart';
import 'package:surveys/views/widgets/survey_entry.dart';

class SurveysPage extends StatefulWidget {
  SurveysPage({Key key}) : super(key: key);

  @override
  _SurveysPageState createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> with AfterLayoutMixin {
  Widget _surveyElement(int index) {
    CollectionProvider userProvider = Provider.of<CollectionProvider>(context, listen: false);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        bool success = await userProvider.loadDetails(index: index, isPersonal: false);

        if (success) {
          bool alreadyVoted = userProvider.hasAlreadyVotedFor(index: index);

          if (alreadyVoted) {
            List<VoteAmount> amounts = await userProvider.getSurveyVotes(index: index, isPersonal: false);
            if (amounts != null) {
              Navigator.of(context).pushNamed(Routes.surveyResults,
                  arguments: {"survey": userProvider.othersSurveys[index], "votes": amounts, "isPersonal": false});
            } else
              MenuUtils.showErrorDialog(context: context, title: "Couldn't load votes");
          } else
            Navigator.of(context).pushNamed(Routes.vote, arguments: {"survey": userProvider.othersSurveys[index]});
        } else {
          MenuUtils.showErrorDialog(context: context, title: "Details loading failed");
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SurveyEntryWidget(survey: userProvider.othersSurveys[index]),
      ),
    );
  }

  Widget _content() => ListView.separated(
      itemBuilder: (context, index) => _surveyElement(index),
      separatorBuilder: (context, index) => Divider(),
      itemCount: Provider.of<CollectionProvider>(context).othersSurveys?.length ?? 0);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
          transitionBetweenRoutes: false,
          middle: Text("Explore surveys"),
          border: null,
          trailing: GestureDetector(
            onTap: () async {
              bool success = await Provider.of<CollectionProvider>(context, listen: false)
                  .loadOthersAndAlreadySubmittedSurveys();
              if (!success) MenuUtils.showErrorDialog(context: context, title: "Couldn't load the surveys");
            },
            child: Icon(CupertinoIcons.refresh),
          ),
        ),
        child: StreamBuilder(
          stream: Provider.of<CollectionProvider>(context).clientEventsStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data != ConnectionEvents.done)
              return Stack(
                children: [
                  Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  Opacity(
                    opacity: 0.25,
                    child: _content(),
                  )
                ],
              );

            return _content();
          },
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<CollectionProvider>(context, listen: false)
        .loadOthersAndAlreadySubmittedSurveys()
        .then((success) {
      if (!success) MenuUtils.showErrorDialog(context: context, title: "Couldn't load the surveys");
    });
  }
}

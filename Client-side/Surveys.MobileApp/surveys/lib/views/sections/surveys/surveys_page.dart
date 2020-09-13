import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/logic/utils/client_events_stream.dart';
import 'package:surveys/views/widgets/survey_entry.dart';

class SurveysPage extends StatefulWidget {
  SurveysPage({Key key}) : super(key: key);

  @override
  _SurveysPageState createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> with AfterLayoutMixin {
  Widget _surveyElement(int index) {
    UserAndCollectionProvider userProvider = Provider.of<UserAndCollectionProvider>(context, listen: false);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        await userProvider.loadDetails(index: index, isPersonal: false);
        bool alreadyVoted = userProvider.hasAlreadyVotedFor(index: index);

        if (alreadyVoted)
          Navigator.of(context).pushNamed(Routes.surveyResults, arguments: {
            "survey": userProvider.othersSurveys[index],
            "votes": await userProvider.getSurveyVotes(index: index, isPersonal: false),
            "isPersonal": false
          });
        else
          Navigator.of(context).pushNamed(Routes.vote, arguments: {"survey": userProvider.othersSurveys[index]});
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
      itemCount: Provider.of<UserAndCollectionProvider>(context).othersSurveys?.length ?? 0);

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
              await Provider.of<UserAndCollectionProvider>(context, listen: false)
                  .loadOthersAndAlreadySubmittedSurveys();
            },
            child: Icon(CupertinoIcons.refresh),
          ),
        ),
        child: StreamBuilder(
          stream: Provider.of<UserAndCollectionProvider>(context).clientEventsStream.stream,
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
    Provider.of<UserAndCollectionProvider>(context, listen: false).loadOthersAndAlreadySubmittedSurveys();
  }
}

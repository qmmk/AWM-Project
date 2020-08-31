import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/views/widgets/survey_entry.dart';

class SurveysPage extends StatefulWidget {
  SurveysPage({Key key}) : super(key: key);

  @override
  _SurveysPageState createState() => _SurveysPageState();
}

class _SurveysPageState extends State<SurveysPage> {
  bool _isWaitingForServer = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _surveyElement(int index) {
    UserAndCollectionProvider userProvider = Provider.of<UserAndCollectionProvider>(context, listen: false);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (userProvider.othersSurveys[index].details == null) {
          setState(() {
            _isWaitingForServer = true;
          });
          await userProvider.loadDetails(index: index, isPersonal: false);
        }

        Navigator.of(context).pushNamed(Routes.surveyResults, arguments: {"survey": userProvider.othersSurveys[index]});
        setState(() {
          _isWaitingForServer = false;
        });
      },
      onLongPress: () {
        Navigator.of(context).pushNamed(Routes.vote, arguments: {"survey": userProvider.othersSurveys[index]});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SurveyEntryWidget(survey: userProvider.othersSurveys[index]),
      ),
    );
  }

  Widget _content() => FutureBuilder(
        future: Provider.of<UserAndCollectionProvider>(context).initOthersSurveys(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Center(
              child: CupertinoActivityIndicator(),
            );

          return ListView.separated(
              itemBuilder: (context, index) => _surveyElement(index),
              separatorBuilder: (context, index) => Divider(),
              itemCount: Provider.of<UserAndCollectionProvider>(context).othersSurveys.length);
        },
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
          transitionBetweenRoutes: false,
          middle: Text("Explore surveys"),
          border: null,
        ),
        child: _isWaitingForServer
            ? Stack(
                children: [
                  Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  Opacity(
                    opacity: 0.25,
                    child: _content(),
                  )
                ],
              )
            : _content());
  }
}

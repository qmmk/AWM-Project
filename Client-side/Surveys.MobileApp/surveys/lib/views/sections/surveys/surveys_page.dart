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
  @override
  void initState() {
    super.initState();
  }

  Widget _surveyElement(int index) {
    UserAndCollectionProvider userProvider = Provider.of<UserAndCollectionProvider>(context, listen: false);

    return Card(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.surveyResults, arguments: {"survey": userProvider.othersSurveys[index]});
        },
        onLongPress: () {
          Navigator.of(context).pushNamed(Routes.vote, arguments: {"survey": userProvider.othersSurveys[index]});
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SurveyEntryWidget(survey: userProvider.othersSurveys[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text("Explore surveys"),
          border: null,
        ),
        child: FutureBuilder(
          future: Provider.of<UserAndCollectionProvider>(context).initOthersSurveys(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Center(
                child: CircularProgressIndicator(),
              );

            return ListView.separated(
                itemBuilder: (context, index) => _surveyElement(index),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: Provider.of<UserAndCollectionProvider>(context).othersSurveys.length);
          },
        ));
  }
}

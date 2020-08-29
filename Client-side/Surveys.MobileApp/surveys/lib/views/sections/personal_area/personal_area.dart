import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_provider.dart';
import 'package:surveys/views/widgets/survey_entry.dart';

class PersonalAreaPage extends StatefulWidget {
  PersonalAreaPage({Key key}) : super(key: key);

  @override
  _PersonalAreaPageState createState() => _PersonalAreaPageState();
}

class _PersonalAreaPageState extends State<PersonalAreaPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _surveyElement(int index) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    return Card(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.of(context).pushNamed(Routes.surveyResults, arguments: {"survey": userProvider.userSurveys[index]});
        },
        onLongPress: () {
          Navigator.of(context)
              .pushNamed(Routes.createSurvey, arguments: {"survey": userProvider.userSurveys[index]}).then((survey) {
            if (survey != null) userProvider.modifySurvey(index, survey);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SurveyEntryWidget(survey: userProvider.userSurveys[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text("My surveys"),
          border: null,
          trailing: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.accountSettings);
            },
            behavior: HitTestBehavior.translucent,
            child: Icon(CupertinoIcons.settings),
          ),
        ),
        child: FutureBuilder(
          future: Provider.of<UserProvider>(context).initPersonalSurveys(),
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
                itemCount: Provider.of<UserProvider>(context).userSurveys.length);
          },
        ));
  }
}

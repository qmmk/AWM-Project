import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/views/widgets/survey_entry.dart';

class PersonalAreaPage extends StatefulWidget {
  PersonalAreaPage({Key key}) : super(key: key);

  @override
  _PersonalAreaPageState createState() => _PersonalAreaPageState();
}

class _PersonalAreaPageState extends State<PersonalAreaPage> {
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
        if (userProvider.userSurveys[index].details == null) {
          setState(() {
            _isWaitingForServer = true;
          });
        }
        await userProvider.loadDetails(index: index, isPersonal: true);
        setState(() {
          _isWaitingForServer = false;
        });
        Navigator.of(context).pushNamed(Routes.surveyResults, arguments: {"survey": userProvider.userSurveys[index]});
      },
      onLongPress: () async {
        if (userProvider.userSurveys[index].details == null) {
          setState(() {
            _isWaitingForServer = true;
          });
        }
        await userProvider.loadDetails(index: index, isPersonal: true);
        setState(() {
          _isWaitingForServer = false;
        });
        Navigator.of(context)
            .pushNamed(Routes.createSurvey, arguments: {"survey": userProvider.userSurveys[index]}).then((survey) {
          if (survey != null) userProvider.modifySurvey(index, survey);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SurveyEntryWidget(survey: userProvider.userSurveys[index]),
      ),
    );
  }

  Widget _content() => FutureBuilder(
        future: Provider.of<UserAndCollectionProvider>(context).initPersonalSurveys(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return Center(
              child: CupertinoActivityIndicator(),
            );

          return ListView.separated(
              itemBuilder: (context, index) => _surveyElement(index),
              separatorBuilder: (context, index) => Divider(),
              itemCount: Provider.of<UserAndCollectionProvider>(context).userSurveys.length);
        },
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
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

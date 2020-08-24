import 'package:flutter/cupertino.dart';
import 'package:surveys/views/sections/create/create_survey_page.dart';
import 'package:surveys/views/sections/surveys/surveys_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), title: Text("Surveys")),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), title: Text("Personal area"))
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return SurveysPage();
            case 1:
              return CreateSurveyPage();
            case 2:
              return SurveysPage();
            default:
              return SurveysPage();
          }
        });
  }
}

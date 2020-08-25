import 'package:flutter/cupertino.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/views/access/access_hub.dart';
import 'package:surveys/views/access/sign_in.dart';
import 'package:surveys/views/access/sign_up.dart';
import 'package:surveys/views/home.dart';
import 'package:surveys/views/sections/create/create_update_entry_page.dart';
import 'package:surveys/views/sections/create/create_update_survey_page.dart';
import 'package:surveys/views/sections/surveys/vote_page.dart';
import 'package:surveys/views/splash.dart';
import 'package:surveys/views/survey_results_page.dart';

class Handlers {
  static Function(RouteSettings) mainHandler = (RouteSettings settings) {
    Map<String, dynamic> arguments = settings.arguments;

    switch (settings.name) {
      case Routes.root:
        return CupertinoPageRoute(builder: (context) => SplashPage());

      case Routes.accessHub:
        return CupertinoPageRoute(builder: (context) => AccessHubPage());

      case Routes.signIn:
        return CupertinoPageRoute(builder: (context) => SignInPage());

      case Routes.signUp:
        return CupertinoPageRoute(builder: (context) => SignUpPage());

      case Routes.home:
        return CupertinoPageRoute(builder: (context) => HomePage());

      case Routes.createSurvey:
        return CupertinoPageRoute(
            builder: (context) => CreateSurveyPage(
                  survey: arguments["survey"],
                ));

      case Routes.createSurveyEntry:
        return CupertinoPageRoute(
            builder: (context) => CreateEntryPage(
                  surveyDetail: arguments != null ? arguments["surveyDetail"] : null,
                ));

      case Routes.surveyResults:
        return CupertinoPageRoute(builder: (context) => SurveyResultsPage(survey: arguments["survey"]));

      case Routes.vote:
        return CupertinoPageRoute(builder: (context) => VotePage(survey: arguments["survey"]));

      default:
        return CupertinoPageRoute(builder: (context) => SplashPage());
    }
  };
}

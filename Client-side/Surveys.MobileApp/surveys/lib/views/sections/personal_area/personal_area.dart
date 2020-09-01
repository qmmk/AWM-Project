import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/logic/utils/client_events_stream.dart';
import 'package:surveys/views/widgets/survey_entry.dart';

class PersonalAreaPage extends StatefulWidget {
  PersonalAreaPage({Key key}) : super(key: key);

  @override
  _PersonalAreaPageState createState() => _PersonalAreaPageState();
}

class _PersonalAreaPageState extends State<PersonalAreaPage> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
  }

  void _loadMenu(int index) {
    UserAndCollectionProvider userProvider = Provider.of<UserAndCollectionProvider>(context, listen: false);
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            title: Text("${userProvider.userSurveys[index].title}"),
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () async {
                    await userProvider.loadDetails(index: index, isPersonal: true);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(Routes.createSurvey,
                        arguments: {"survey": userProvider.userSurveys[index]}).then((survey) {
                      if (survey != null) userProvider.modifySurvey(index, survey);
                    });
                  },
                  child: Text("Edit")),
              CupertinoActionSheetAction(
                  isDestructiveAction: true,
                  onPressed: () async {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                              title: Text("Are you sure to remove this survey?"),
                              content: Text("This will also remove its entries and votes"),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: Text("Yes"),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                                CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    })
                              ],
                            )).then((removeIt) async {
                      if (removeIt ?? false) {
                        await userProvider.removeSurvey(index: index, isPersonal: true);
                        Navigator.of(context).pop();
                      }
                    });
                  },
                  child: Text("Remove"))
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  )),
            )));
  }

  Widget _surveyElement(int index) {
    UserAndCollectionProvider userProvider = Provider.of<UserAndCollectionProvider>(context, listen: false);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        await userProvider.loadDetails(index: index, isPersonal: true);
        Navigator.of(context).pushNamed(Routes.surveyResults, arguments: {"survey": userProvider.userSurveys[index]});
      },
      onLongPress: () async {
        _loadMenu(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SurveyEntryWidget(survey: userProvider.userSurveys[index]),
      ),
    );
  }

  Widget _content() => ListView.separated(
      itemBuilder: (context, index) => _surveyElement(index),
      separatorBuilder: (context, index) => Divider(),
      itemCount: Provider.of<UserAndCollectionProvider>(context).userSurveys?.length ?? 0);

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
    Provider.of<UserAndCollectionProvider>(context, listen: false).loadPersonalSurveys();
  }
}

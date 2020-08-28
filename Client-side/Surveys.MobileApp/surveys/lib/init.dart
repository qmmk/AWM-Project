import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:surveys/application.dart';
import 'package:surveys/logic/configs/routing/handlers.dart';
import 'package:surveys/logic/services/access_service.dart';

class Init extends StatefulWidget {
  final Application application = Application();

  Init({Key key}) : super(key: key);

  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAppWithTheme();
  }
}

class CupertinoAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    
    return CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      title: 'Surveys',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Handlers.mainHandler,
    );
  }
}

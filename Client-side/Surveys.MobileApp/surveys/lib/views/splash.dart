import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:surveys/logic/configs/routing/routes.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Text("Surveys"),
    ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(milliseconds: 750)).then((value) =>
        Navigator.of(context).pushReplacementNamed(Routes.accessHub));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:surveys/logic/configs/routing/routes.dart';

class AccessHubPage extends StatelessWidget {
  const AccessHubPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Column(
        children: [
          Expanded(flex: 10, child: Center(child: Text("The smartest way to take and create surveys"))),
          Expanded(
            flex: 10,
            child: Column(
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.signIn);
                  },
                  child: Text("Sign in"),
                ),
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.signUp);
                  },
                  child: Text("Sign up"),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

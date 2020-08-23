import 'package:flutter/cupertino.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: "Back",
          backgroundColor: CupertinoColors.white,
          border: null,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CupertinoTextField(
                    placeholder: "Enter email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CupertinoTextField(
                    placeholder: "Enter password",
                    obscureText: true,
                    keyboardType: TextInputType.text,
                  ),
                ),
                CupertinoButton(
                    child: Text(
                      "Sign up",
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        ));
  }
}

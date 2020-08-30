import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/models/user_model.dart';

class AccountSettingsPage extends StatefulWidget {
  AccountSettingsPage({Key key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> with AfterLayoutMixin {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(
                "Logout failed",
                style: TextStyle(color: Colors.red),
              ),
              content: Text("Please try again later"),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Material(
                        child: TextFormField(
                          controller: _usernameController,
                          validator: (s) {
                            if (s.trim().isEmpty) return "Please enter your username";

                            return null;
                          },
                          decoration: InputDecoration(hintText: "Enter your username"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Material(
                        child: TextFormField(
                          controller: _passwordController,
                          validator: (s) {
                            if (s.trim().isEmpty) return "Please enter your new password";
                            if (s != _confirmPasswordController.text) return "Passwords don't match";

                            return null;
                          },
                          decoration: InputDecoration(hintText: "Enter new password"),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Material(
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          validator: (s) {
                            if (s.trim().isEmpty) return "Please confirm your new password";
                            if (s != _passwordController.text) return "Passwords don't match";

                            return null;
                          },
                          decoration: InputDecoration(hintText: "Confirm new password"),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    CupertinoButton(
                        child: Text(
                          "Update account",
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState.validate()) return;

                          String username = _usernameController.text;
                          String password = _passwordController.text;

                          Provider.of<UserAndCollectionProvider>(context, listen: false).setUsername(username);
                        })
                  ],
                ),
              ),
              CupertinoButton(
                  onPressed: () async {
                    bool success = await Provider.of<UserAndCollectionProvider>(context, listen: false).logout();
                    if (success)
                      Navigator.of(context).pushNamedAndRemoveUntil(Routes.accessHub, ModalRoute.withName(Routes.root));
                    else
                      _showErrorDialog();
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.redAccent, fontSize: 18),
                  ))
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      _usernameController.text = Provider.of<UserAndCollectionProvider>(context, listen: false).user.username;
    });
  }
}

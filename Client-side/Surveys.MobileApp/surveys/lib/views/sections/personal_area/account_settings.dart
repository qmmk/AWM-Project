import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveys/logic/providers/current_user_provider.dart';
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

                    Provider.of<UserProvider>(context, listen: false).setUser(User(username: username));
                  })
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      _usernameController.text = Provider.of<UserProvider>(context, listen: false).user.username;
    });
  }
}

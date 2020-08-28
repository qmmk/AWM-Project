import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/views/home.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Material(
                      child: TextFormField(
                        controller: _mailController,
                        validator: (s) {
                          if (s.trim().isEmpty) return "Please enter your email";
                          if (!EmailValidator.validate(s)) return "Please enter a valid email address";

                          return null;
                        },
                        decoration: InputDecoration(hintText: "Enter email"),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Material(
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (s) {
                          if (s.trim().isEmpty) return "Please enter your password";

                          return null;
                        },
                        decoration: InputDecoration(hintText: "Enter password"),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  CupertinoButton(
                      child: Text(
                        "Sign in",
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) return;

                        Navigator.of(context).pushAndRemoveUntil(
                            CupertinoPageRoute(builder: (context) => HomePage()), ModalRoute.withName(Routes.root));
                      })
                ],
              ),
            ),
          ),
        ));
  }
}

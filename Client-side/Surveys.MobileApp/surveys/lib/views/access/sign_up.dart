import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_client/model/login_response.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/logic/services/access_service.dart';
import 'package:surveys/logic/utils/http_utils.dart';
import 'package:surveys/models/user_model.dart';
import 'package:surveys/views/home.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AccessService _accessService = AccessService();
  bool _isWaitingForServer = false;
  bool _incorrectSignUp = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: "Back",
          backgroundColor: Colors.transparent,
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
                        controller: _usernameController,
                        validator: (s) {
                          if (_incorrectSignUp) return "Please enter a valid username";
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
                          if (_incorrectSignUp) return "Please enter a valid password";
                          if (s.trim().isEmpty) return "Please enter your password";

                          return null;
                        },
                        decoration: InputDecoration(hintText: "Enter password"),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  _isWaitingForServer
                      ? Center(
                          child: CupertinoActivityIndicator(
                            animating: true,
                            radius: 20,
                          ),
                        )
                      : CupertinoButton(
                          child: Text(
                            "Sign up",
                          ),
                          onPressed: () async {
                            if (!_formKey.currentState.validate()) return;

                            String username = _usernameController.text;
                            String password = _passwordController.text;

                            try {
                              setState(() {
                                _isWaitingForServer = true;
                              });
                              await _accessService.addUser(username: username, password: password);
                              LoginResponse response =
                                  await _accessService.login(username: username, password: password);
                              HttpUtils.registerToken(response.accessToken);
                              await HttpUtils.storeRefreshToken(response.refreshToken.rToken);

                              Provider.of<UserAndCollectionProvider>(context, listen: false)
                                  .setUser(User(id: response.pid, username: username));

                              Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(builder: (context) => HomePage()),
                                  ModalRoute.withName(Routes.root));
                            } on DioError catch (e) {
                              _incorrectSignUp = true;
                              _formKey.currentState.validate();
                              _incorrectSignUp = false;
                            }
                            setState(() {
                              _isWaitingForServer = false;
                            });
                          })
                ],
              ),
            ),
          ),
        ));
  }
}

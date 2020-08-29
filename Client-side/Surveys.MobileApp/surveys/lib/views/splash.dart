import 'package:after_layout/after_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:survey_client/model/login_response.dart';
import 'package:surveys/logic/configs/routing/routes.dart';
import 'package:surveys/logic/services/access_service.dart';
import 'package:surveys/logic/utils/http_utils.dart';
import 'package:surveys/logic/providers/current_user_provider.dart';
import 'package:surveys/models/user_model.dart';

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
    HttpUtils.getRefreshToken().then((refreshToken) {
      if (refreshToken == null)
        Future.delayed(Duration(milliseconds: 750))
            .then((value) => Navigator.of(context).pushReplacementNamed(Routes.accessHub));
      else {
        AccessService accessService = AccessService();
        try {
          accessService.fastLogin(refreshToken: refreshToken).then((LoginResponse response) {
            Provider.of<UserProvider>(context, listen: false).setUser(User(username: response.userName));

            HttpUtils.registerToken(response.accessToken);
            HttpUtils.storeRefreshToken(response.refreshToken.rToken).then((_) {
              Navigator.of(context).pushReplacementNamed(Routes.home);
            });
          });
        } on DioError {
          Navigator.of(context).pushReplacementNamed(Routes.accessHub);
        }
      }
    });
  }
}

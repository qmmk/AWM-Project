import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:surveys/logic/providers/base_provider.dart';
import 'package:surveys/logic/services/access_service.dart';
import 'package:surveys/logic/utils/http_utils.dart';
import 'package:surveys/models/user_model.dart';

class UserProvider extends BaseProvider {
  User _user = User();
  AccessService _accessService = AccessService();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> updateUser({@required User user, @required String password}) async {
    int pid = _user.id;
    _user = user;
    _user.id = pid;
    await _accessService.addUser(pid: pid, username: _user.username, password: password);
    notifyListeners();
  }

  Future<bool> logout({bool onlyResetUserData = false}) async {
    try {
      if (!onlyResetUserData) await _accessService.logout(pid: _user.id);
      await HttpUtils.invalidateTokens();
      _user = null;
      return true;
    } on DioError {
      return false;
    }
  }
}

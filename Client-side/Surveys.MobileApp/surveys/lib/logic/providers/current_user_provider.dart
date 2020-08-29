import 'package:dio/dio.dart';
import 'package:surveys/logic/providers/survey_provider.dart';
import 'package:surveys/logic/services/access_service.dart';
import 'package:surveys/logic/utils/http_utils.dart';
import 'package:surveys/models/user_model.dart';

class UserProvider extends SurveyProvider {
  AccessService _accessService = AccessService();
  User _user = User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUsername(String username) {
    _user.username = username;
    notifyListeners();
  }

  void setPassword(String password) {}

  Future<bool> logout() async {
    try {
      await _accessService.logout(pid: _user.pid);
      await HttpUtils.invalidateTokens();
      _user = null;
      return true;
    } on DioError catch (e){
      return false;
    }
  }
}

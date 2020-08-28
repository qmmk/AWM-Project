import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:surveys/logic/utils/http_utils.dart';

class Application {
  static GetIt getIt = GetIt.instance;

  Application() {
    _initializeApplicationInstances();
  }

  void _initializeApplicationInstances() {
    getIt.registerSingleton(FlutterSecureStorage(), instanceName: "secureStorage");
    getIt.registerSingleton(HttpUtils.getSurveyClient(), instanceName: "surveyClient");
  }
}

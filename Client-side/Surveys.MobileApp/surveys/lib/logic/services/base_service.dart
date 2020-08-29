import 'package:get_it/get_it.dart';
import 'package:survey_client/api.dart';

class BaseService {
  SurveyClient _client;

  SurveyClient get client => _client;

  BaseService() {
    _client = GetIt.instance.get(instanceName: "surveyClient");
  }
}

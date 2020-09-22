import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:surveys/logic/providers/user_and_collection_provider.dart';
import 'package:surveys/logic/utils/http_utils.dart';

final GlobalKey<NavigatorState> globalAppNavigator = new GlobalKey<NavigatorState>();

class Application {
  static GetIt getIt = GetIt.instance;

  Application() {
    _initializeApplicationInstances();
  }

  void _initializeApplicationInstances() {
    getIt.registerSingleton(FlutterSecureStorage(), instanceName: "secureStorage");
    getIt.registerSingleton(HttpUtils.getSurveyClient(), instanceName: "surveyClient");
  }

  List<SingleChildWidget> getProviders() => [
        ChangeNotifierProvider<UserAndCollectionProvider>(
          create: (_) => UserAndCollectionProvider(),
        )
      ];
}

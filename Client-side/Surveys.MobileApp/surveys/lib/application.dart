import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class Application {
  static GetIt getIt = GetIt.instance;

  Application() {
    _initializeApplicationInstances();
  }

  void _initializeApplicationInstances() {
    getIt.registerSingleton(FlutterSecureStorage(),
        instanceName: "secureStorage");
  }
}

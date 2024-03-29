import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:surveys/init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(Init());
  });
}

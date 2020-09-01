import 'package:flutter/cupertino.dart';
import 'package:surveys/logic/utils/client_events_stream.dart';

abstract class BaseProvider with ChangeNotifier {
  ClientEventsStream clientEventsStream = new ClientEventsStream();

  void loading() {
    clientEventsStream.sink.add(ConnectionEvents.loading);
  }

  void done() {
    clientEventsStream.sink.add(ConnectionEvents.done);
  }

  @override
  void dispose() {
    clientEventsStream.dispose();
    super.dispose();
  }
}

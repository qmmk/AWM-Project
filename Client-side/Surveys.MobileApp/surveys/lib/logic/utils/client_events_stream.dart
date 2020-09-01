import 'dart:async';

class ClientEventsStream {
  StreamController<ConnectionEvents> _controller = new StreamController.broadcast();
  Sink<ConnectionEvents> get sink => _controller.sink;
  Stream<ConnectionEvents> get stream => _controller.stream;

  void dispose() {
    _controller.close();
    _controller = new StreamController.broadcast();
  }
}

enum ConnectionEvents { loading, done, idle }
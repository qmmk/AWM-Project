import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final counterProvider = StateNotifierProvider((ref) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
    void decrement() {
    if (state <= 0) return;
    state--;
  }
}

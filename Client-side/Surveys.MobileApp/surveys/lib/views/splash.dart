import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:surveys/logic/counter_provider.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoPageScaffold(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterWidget(),
              CupertinoButton(
                onPressed: () {
                  context.read(counterProvider).increment();
                },
                child: Text("Increment"),
              ),
              CupertinoButton(
                onPressed: () {
                  context.read(counterProvider).decrement();
                },
                child: Text("Decrement"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final count = watch(counterProvider.state);
    return Text(
      '$count',
      style: TextStyle(fontSize: 25),
    );
  }
}

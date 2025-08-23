// The mixin is needed because it contains 'notifyListeners()'
import 'package:flutter/material.dart';
import 'package:dalell/constant.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light(),
    home: const ExamplePage(),
  ));
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // The type of 'counter' is CounterModel
    final counter = Provider.of<CounterModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("data"),
          backgroundColor: primaryColor,
        ),
        body: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
// FlatButtons and Text widget

          ElevatedButton(
            child: const Text(
              "+1",
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
            onPressed: () => counter.increment(),
          ),
          Text(
            "${counter.currentCount}",
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            child: const Text(
              "-1",
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            onPressed: () => counter.decrement(),
          ),
        ])));
  }
}

class Something {
  final description = "something is better than nothing";
  final descriptionCache = {};
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Provder Class'),
          backgroundColor: primaryColor,
        ),
        body: Provider<Something>(
          create: (context) => Something(),

          child: Consumer<Something>(builder: (_, value, __) {
            return Text(value.description);
          }),
          // child: ChildWidget(),
        ));
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<Something>(context).description;
    return Text(value);
  }
}

class CounterModel with ChangeNotifier {
  int _counter = 0;
  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }

  int get currentCount => _counter;
}

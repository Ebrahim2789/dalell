import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Something {
  final description = "something is better than nothing";
  final descriptionCache = {};
}

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Something>(
      create: (context) => Something(),
      child: ChildWidget(),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<Something>(context);

    return Text("${value.description}");
  }
}

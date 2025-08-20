import 'package:flutter/material.dart';
import 'package:dalell/app/loyout.dart';

class FlexScreen extends StatelessWidget {
  const FlexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flex Container'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...header(context, 'Expanded'),
            const DemoExpanded(),
            ...header(context, 'Flexible'),
            const DemoFlexible(),
            const Expanded(
              child: Spacer(),
            ),
            const DemoFooter()
          ],
        ));
  }
}

Iterable<Widget> header(BuildContext context, String lable) {
  return [
    const SizedBox(height: 20),
    Text(
      lable,
      
      style: Theme.of(context).textTheme.headlineSmall,
    )
  ];
}

class DemoExpanded extends StatelessWidget {
  const DemoExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Row(
        children: [
          LabeledContainer(
            text: '100',
            width: 100,
            color: Colors.blueGrey,
          ),
          Expanded(
            child: LabeledContainer(
              text: 'reminder',
              color: Colors.lightBlue,
              textColor: Colors.purple,
            ),
          ),
          LabeledContainer(
            text: '400',
            width: 40,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}

class DemoFlexible extends StatelessWidget {
  const DemoFlexible({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: LabeledContainer(
              text: '25%',
              color: Colors.orange,
            ),
          ),
          Flexible(
            flex: 1,
            child: LabeledContainer(
              text: '25%',
              color: Colors.deepOrange,
            ),
          ),
          Flexible(
            flex: 2,
            child: LabeledContainer(
              text: '50%',
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class DemoFooter extends StatelessWidget {
  const DemoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Text(
        'Pinned to the Bottom',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}

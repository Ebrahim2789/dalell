
import 'package:flutter/material.dart';
class ContainerWithBoxDecrotionWidth extends StatelessWidget {
  const ContainerWithBoxDecrotionWidth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100.0),
              bottomRight: Radius.circular(10.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.lightGreen,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              )
            ],
          ),
       
        ),
     const ButtonWidgetDemo(),
      ],
    );
  }
}

class BoxWithShadwo extends StatefulWidget {
  const BoxWithShadwo({super.key});

  @override
  State<BoxWithShadwo> createState() => _BoxWithShadwoState();
}

class _BoxWithShadwoState extends State<BoxWithShadwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(100.0),
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(100),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.lightGreen.shade200,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.green,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
              BoxShadow(
                color: Colors.blue,
                blurRadius: 10,
                offset: Offset(30.0, 10.0),
              ),
            ],
          ),
        
        ),
        Container(
          height: 20.0,
        ),
      ],
    );
  }
}

class ButtonWidgetDemo extends StatefulWidget {
  const ButtonWidgetDemo({super.key});

  @override
  State<ButtonWidgetDemo> createState() => _ButtonWidgetDemoState();
}

class _ButtonWidgetDemoState extends State<ButtonWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => {},
          child: const Icon(
            Icons.flag,
            color: Colors.blue,
          ),
        ),
        Row(
          children: [
            FilledButton(
              onPressed: () {},
              child: const Icon(
                Icons.flag,
                color: Colors.blue,
              ),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text('Login'),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.flight),
              iconSize: 42.0,
              color: Colors.black,
              tooltip: 'Flight',
            ),
          ],
        ),
      ],
    );
  }
}

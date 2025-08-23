import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dalell/data/models/product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    readJsonFile().then((Value) {
      setState(() {
        myproduct = Value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('json'),
        ),
        body: ListView.separated(
          itemCount: myproduct.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(myproduct[index].name),
              subtitle: Text(myproduct[index].description),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ));
  }

  String pizzaString = '';
  List<Product> myproduct = [];

  Future<List<Product>> readJsonFile() async {
    String myString =
        await DefaultAssetBundle.of(context).loadString('assets/readme.json');

    List mapproduct = jsonDecode(myString);

    final List<Product> people =
        mapproduct.map((value) => Product.fromMap(value)).toList();

    return people;
  }
}

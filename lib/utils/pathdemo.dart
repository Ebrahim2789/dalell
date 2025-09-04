import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

class PathDemo extends StatefulWidget {
  const PathDemo({super.key});

  @override
  State<PathDemo> createState() => _PathDemoState();
}

class _PathDemoState extends State<PathDemo> {
  @override
  void initState() {
    super.initState();

    getPathDevice().then((_) {
      myFile = File('$getPath/product.txt');
      writeFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Application directory"),
      ),
      body: Column(children: [
        Text("appliction path: {$getPath}"),
        const SizedBox(
          height: 3,
        ),
        Text("temppath:{$tempPath}"),
        ElevatedButton(
          child: const Text('Read File'),
          onPressed: () => readFile(),
        ),
        Text(fileText),
      ]),
    );
  }

  late File myFile;
  String fileText = '';
  String getPath = "";
  String tempPath = "";
  Future getPathDevice() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    setState(() {
      getPath = docDir.path;
      tempPath = tempDir.path;
    });
  }

  Future<bool> writeFile() async {
    try {
      await myFile.writeAsString('Margherita, Capricciosa, Napoli');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> readFile() async {
    try {
// Read the file.
      String fileContent = await myFile.readAsString();
      setState(() {
        fileText = fileContent;
      });
      return true;
    } catch (e) {
// On error, return false.
      return false;
    }
  }
}

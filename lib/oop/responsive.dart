import 'package:flutter/material.dart';

class ResponsiveUi extends StatefulWidget {
  const ResponsiveUi({super.key});

  @override
  State<ResponsiveUi> createState() => _ResponsiveUiState();
}

class _ResponsiveUiState extends State<ResponsiveUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive UI'),),
      body: LayoutBuilder(builder: (BuildContext contex ,BoxConstraints sizes) {
        if (sizes.maxWidth< 500) {
          return const ListDemo();
          
        }else{
          return const GridDemo() ;
        }

      }),
    );
  }
}



class ListDemo extends StatelessWidget {
  const ListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final orantion=MediaQuery.of(context).orientation;
    Text("$width");
    Text("$orantion");

    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context,id){
        return ListTile(
          leading: const Icon(Icons.add_box),
          title: Text('Iteem$id'),
        );

    });
  }
}


class GridDemo extends StatelessWidget {
  const GridDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2,
    children: List.generate(100, (index){
      return ListTile(
        leading: const Icon(Icons.add_box),
        title: Text('Item$index'),
      );
    }),);
  
}}
import 'package:flutter/material.dart';
import 'package:dalell/container/info_page.dart';

class ListData {
  final String city;
  final String location;
  final IconData icon;
  ListData(this.city, this.location, this.icon);
  @override
  String toString() {
    return '$city $location $icon';
  }
}

List<Map> data = [
  {'city': 'Dubia', 'location': 'UAE', "icon": Icons.abc},
  {'city': 'Dubia', 'location': 'UAE', "icon": Icons.abc},
  {'city': 'nairob', 'location': 'UAE', "icon": Icons.abc},
];
List<ListData> mapping() {
  final name = data.map<ListData>((Map names) {
    final city = names['city'];
    final location = names['location'];
    final icon = names['icon'];
    return ListData(city, location, icon);
  }).toList();
  return name;
}

class ListDemos extends StatelessWidget {
  const ListDemos({super.key});
  void _itemPressed(BuildContext context, ListData item) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InfoPage(item: item),
        ),
      );

  @override
  Widget build(BuildContext context) {
    List<String> names = ['ali', 'adma', 'kadir'];
    final allAges = data.map<String>((person) => person['city']);

    final lists = mapping();
    return Scaffold(
        appBar: AppBar(
          title: const Text('data'),
        ),
        body: Center(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int count) {
              return ListTile(
                  title: Text(lists[count].city),
                  leading: const Icon(Icons.star_border),
                  onTap: () => _itemPressed(context, lists[count]));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: lists.length,
          ),
        ));
  }
}

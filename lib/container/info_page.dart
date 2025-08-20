import 'package:flutter/material.dart';
import 'package:dalell/container/listdemo.dart';

class PopUpMenu {
  final Icon icon;
  final String title;

  PopUpMenu({required this.icon, required this.title});
}

class InfoPage extends StatelessWidget {
  final ListData item;

  const InfoPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    int selectedValue = 0;

    List<PopUpMenu> popUpMenu = [
      PopUpMenu(icon: const Icon(Icons.settings), title: 'setting'),
      PopUpMenu(icon: const Icon(Icons.download), title: 'Download'),
      PopUpMenu(icon: const Icon(Icons.help), title: 'Help'),
      PopUpMenu(icon: const Icon(Icons.bookmark), title: 'About'),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<PopUpMenu>(
              initialValue: popUpMenu.first,
              icon: const Icon(Icons.menu),
              onSelected: ((value) {
                selectedValue = 1;
              }),
              itemBuilder: (context) {
                return popUpMenu.map((PopUpMenu popUpMenu) {
                  return PopupMenuItem<PopUpMenu>(
                    value: popUpMenu,
                    child: Row(
                      children: [
                        Icon(popUpMenu.icon.icon),
                        const Divider(),
                        Text(popUpMenu.title)
                      ],
                    ),
                    onTap: (){
                      
                    }
                  );
                }).toList();
              })
        ],
        leading: BackButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const ListDemos())),
        ),
      ),
      body: Center(child: Text(item.location)),
    );
  }
}

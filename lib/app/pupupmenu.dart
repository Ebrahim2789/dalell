import 'package:dalell/config/app_routes.dart';
import 'package:dalell/routes/routes.dart';
import 'package:flutter/material.dart';

final routeObserverServices=RouteObserverServices();
    String? routes=routeObserverServices.currentRoute;

    String? activeRoute=routes == "homePages" ? RouteGenerator.marchentPages : routes == "marchentPages" ? RouteGenerator.marchentPages:routes;
enum Menu { menus, logout, download, preview, link, setting }

class Menus {
  final String title;
  final Icon icon;

  Menus({required this.title, required this.icon});
}

// String selectedMenu='';
Menu? selectedMenu;

class PopupMenuButtonWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const PopupMenuButtonWidget({super.key, required String title});

  @override
  State<PopupMenuButtonWidget> createState() => _PopupMenuButtonWidgetState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _PopupMenuButtonWidgetState extends State<PopupMenuButtonWidget> {
  @override
  void initState() {
    super.initState();
  }

  Size get preferredSize => const Size.fromHeight(75.0);

  @override
  Widget build(BuildContext context) {
    List<Menus> menu = [];

    menu
      ..add(Menus(title: Menu.download.name, icon: const Icon(Icons.download)))
      ..add(Menus(
          title: Menu.logout.name, icon: const Icon(Icons.logout_outlined)))
      ..add(Menus(title: Menu.link.name, icon: const Icon(Icons.link)))
      ..add(Menus(title: Menu.preview.name, icon: const Icon(Icons.preview)))
      ..add(Menus(
          title: Menu.menus.name, icon: const Icon(Icons.menu_book_outlined)))
      ..add(Menus(title: Menu.setting.name, icon: const Icon(Icons.settings)));

    Menus? valueSelected;
    return Scaffold(
        appBar: AppBar(
          title: const Text('PopUpMenuButton'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(  RouteGenerator.homePages,);
              },
              icon: const Icon(Icons.add),
            ),
            PopupMenuButton<Menu>(
              initialValue: selectedMenu,
              onSelected: (item) async {
                setState(() {
                  selectedMenu = item;
                });

                switch (item) {
                  case Menu.logout:
                    Navigator.pop(context);
                  case Menu.download:
                    Navigator.of(context).pushNamed(RouteGenerator.homePages,);

                  case Menu.preview:
                    break;

                  case Menu.link:
                    break;
                  case Menu.setting:
                    break;
                  case Menu.menus:
                    break;
                }
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem<Menu>(
                    value: Menu.logout,
                    child: ListTile(
                        title: Text('Log out'),
                        leading: Icon(Icons.logout_outlined)),
                  ),
                  PopupMenuItem<Menu>(
                    value: Menu.logout,
                    child: ListTile(
                      leading: Icon(Icons.note_add_outlined),
                      title: Text('NewNote'),
                    ),
                  ),
                  PopupMenuItem<Menu>(
                    value: Menu.link,
                    child: ListTile(
                      leading: Icon(Icons.share_outlined),
                      title: Text('Share'),
                    ),
                  ),
                  PopupMenuItem<Menu>(
                    value: Menu.download,
                    child: ListTile(
                      leading: Icon(Icons.link_outlined),
                      title: Text('Get link'),
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<Menu>(
                    value: Menu.preview,
                    child: ListTile(
                      leading: Icon(Icons.delete_outline),
                      title: Text('Remove'),
                    ),
                  ),
                  PopupMenuItem<Menu>(
                    value: Menu.setting,
                    child: ListTile(
                      leading: Icon(Icons.visibility_outlined),
                      title: Text('Setting'),
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        body: Container(
          color: Colors.lightGreen.shade100,
          height: preferredSize.height,
          width: double.infinity,
          child: Center(
            child: PopupMenuButton<Menus>(
              initialValue: valueSelected,
              icon: const Icon(Icons.view_list),
              onSelected: ((valueSelected) async {
                // print('valueSelected: ${valueSelected.title}');
                setState(() {
                  valueSelected = valueSelected;
                });
              }),
              itemBuilder: (BuildContext context) {
                return menu.map((Menus todoMenuItem) {
                  return PopupMenuItem<Menus>(
                    value: todoMenuItem,
                    child: Row(
                      children: <Widget>[
                        Icon(todoMenuItem.icon.icon),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                        ),
                        Text(todoMenuItem.title),
                        const PopupMenuDivider(),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ));
  }
}



  PopupMenuButton<Menu> popUpMenuButtonForHomes() {



    return PopupMenuButton<Menu>(itemBuilder: (context) {
          return  [
            PopupMenuItem<Menu>(
              value: Menu.logout,
              onTap:(){

    
              Navigator.popAndPushNamed(context,RouteGenerator.marchentPages);
                
              
            
            }, 
              child: const ListTile(
                  title: Text('Log out'),
                  leading: Icon(Icons.logout_outlined)),
            ),
            PopupMenuItem<Menu>(
              value: Menu.logout,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.homePages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.note_add_outlined),
                title: Text('NewNote'),
              ),
            ),
            PopupMenuItem<Menu>(
              value: Menu.link,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.homePages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.share_outlined),
                title: Text('Share'),
              ),
            ),
            PopupMenuItem<Menu>(
              value: Menu.download,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.homePages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.link_outlined),
                title: Text('Get link'),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<Menu>(
              value: Menu.preview,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.homePages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('Remove'),
              ),
            ),
            PopupMenuItem<Menu>(
              value: Menu.setting,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.homePages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.visibility_outlined),
                title: Text('Setting'),
              ),
            ),
          ];
        });
  }

  PopupMenuButton<Menu> popUpMenuButtonForAll() {
    return PopupMenuButton<Menu>(itemBuilder: (context) {
          return  [
            PopupMenuItem<Menu>(
              value: Menu.logout,
              onTap:(){
            Navigator.popAndPushNamed(context, RouteGenerator.homePages);
                
            }, 
              child: const ListTile(
                  title: Text('Log out'),
                  leading: Icon(Icons.logout_outlined)),
            ),
            PopupMenuItem<Menu>(
              value: Menu.logout,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.marchentPages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.note_add_outlined),
                title: Text('NewNote'),
              ),
            ),
            PopupMenuItem<Menu>(
              value: Menu.link,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.marchentPages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.share_outlined),
                title: Text('Share'),
              ),
            ),
            PopupMenuItem<Menu>(
              value: Menu.download,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.marchentPages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.link_outlined),
                title: Text('Get link'),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<Menu>(
              value: Menu.preview,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.marchentPages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('Remove'),
              ),
            ),
            PopupMenuItem<Menu>(
              value: Menu.setting,
                   onTap:(){
              Navigator.of(context).pushNamed(  RouteGenerator.marchentPages,);
            }, 
              child: const ListTile(
                leading: Icon(Icons.visibility_outlined),
                title: Text('Setting'),
              ),
            ),
          ];
        });
  }

import 'package:flutter/material.dart';
import 'package:dalell/routes.dart';

class TabbarWidget extends StatefulWidget {
  const TabbarWidget({super.key, required String title});

  @override
  State<TabbarWidget> createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('app bar'),
      ),
      drawer: const LeftDrawerWidget(),
      // endDrawer: const RightDrawerWidget(),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

class MenuListTileWidget extends StatefulWidget {
  const MenuListTileWidget({super.key});

  @override
  State<MenuListTileWidget> createState() => _MenuListTileWidgetState();
}

class _MenuListTileWidgetState extends State<MenuListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('home'),

               onTap:(){
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
              }, 
      
        ),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Star'),
             onTap:(){
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
              }, 
        ),
        ListTile(
          leading: const Icon(Icons.alarm),
          title: const Text('Box'),
             onTap:(){
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
              }, 
        ),
        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Setting'),
          onTap: () => {
            Navigator.pop(context),
          },
        ),
      ],
    );
  }
}

class LeftDrawerWidget extends StatefulWidget {
  const LeftDrawerWidget({super.key});

  @override
  State<LeftDrawerWidget> createState() => _LeftDrawerWidgetState();
}

class _LeftDrawerWidgetState extends State<LeftDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          UserAccountsDrawerHeader(
            currentAccountPicture: Icon(
              Icons.face,
              color: Colors.white,
              size: 48.0,
            ),
            accountName: Text('Abre'),
            accountEmail: Text('abre@gmail'),
            otherAccountsPictures: [
              Icon(
                Icons.bookmark_add_outlined,
                color: Colors.blue,
              ),
            ],
            decoration: BoxDecoration(
                image: DecorationImage(
                  
                    image: AssetImage(
                      'assets/images/user.png',
                    ),
                    fit: BoxFit.cover)),
          ),
          MenuListTileWidget(),
        ],
      ),
    );
  }
}

class RightDrawerWidget extends StatefulWidget {
  const RightDrawerWidget({super.key});

  @override
  State<RightDrawerWidget> createState() => _RightDrawerWidgetState();
}

class _RightDrawerWidgetState extends State<RightDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(color: Colors.blue),
            child: Icon(
              Icons.face,
              color: Colors.white54,
              size: 128.0,
            ),
          ),
          MenuListTileWidget(),
        ],
      ),
    );
  }
}

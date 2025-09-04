import 'package:flutter/material.dart';
import 'package:dalell/routes/routes.dart';

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
          onTap: () {
            Navigator.of(context).pushNamed(
              RouteGenerator.homePages,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Star'),
          onTap: () {
            Navigator.of(context).pushNamed(
              RouteGenerator.homePages,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.alarm),
          title: const Text('Box'),
          onTap: () {
            Navigator.of(context).pushNamed(
              RouteGenerator.homePages,
            );
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
      backgroundColor: Colors.grey,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: const [
          UserAccountsDrawerHeader(
            
            // currentAccountPictureSize:   Size.fromRadius(30.0),
            // otherAccountsPicturesSize: Size.square(40.0),
            // currentAccountPicture: CircleAvatar(
            //     radius: 50,
            //     backgroundColor: Colors.orange,
            //     child: Icon(
            //       Icons.person,
            //     )),
       
      decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orangeAccent,
                image: DecorationImage(image:AssetImage ("assets/images/user.png"))
            ),
                //  margin: EdgeInsets.only(top: 10),
            accountName: Text('Abre',style: TextStyle(),),
            accountEmail: Text('abre@gmail'),

            //   otherAccountsPictures: [

            // Image(image: AssetImage("assets/images/user.png"))
            //   ],
      
            
          ),
          Divider(),
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

import 'package:flutter/material.dart';
import 'package:dalell/app/drawer.dart';
import 'package:dalell/app/pupupmenu.dart';
import 'package:dalell/models/homepage.dart';
import 'package:dalell/models/lucypage.dart';
import 'package:dalell/models/product_page.dart';
import 'package:dalell/models/team_page.dart';
import 'package:dalell/models/userprofile.dart';
import 'package:dalell/views/login_page.dart';
import 'package:dalell/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  List listpag = [];
  int _currentIndex = 0;
  late Widget _currentPage;

  void _changePage(int selectedIndex) {
    setState(() {
      _currentPage = listpag[selectedIndex];
      _currentIndex = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    listpag
      // ..add(const HomePage())
       ..add(const Dashboard())  
      ..add(const ProductPage())
      ..add( const LuckyDrawPage())
      ..add( const TeamPage())
      ..add( const MePage ());
    _currentPage = const LoginPages();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0
            ? 'Home'
            : _currentIndex == 1
                ? 'Product'
                : _currentIndex == 2
                    ? 'Delevery'
                    : _currentIndex == 3
                        ? 'Order'
                        : 'Me'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_book_outlined),
          ),
          PopupMenuButton<Menu>(itemBuilder: (context) {
            return  [
              PopupMenuItem<Menu>(
                value: Menu.logout,
                onTap:(){
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
              }, 
                child: const ListTile(
                    title: Text('Log out'),
                    leading: Icon(Icons.logout_outlined)),
              ),
              PopupMenuItem<Menu>(
                value: Menu.logout,
                     onTap:(){
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
              }, 
                child: const ListTile(
                  leading: Icon(Icons.note_add_outlined),
                  title: Text('NewNote'),
                ),
              ),
              PopupMenuItem<Menu>(
                value: Menu.link,
                     onTap:(){
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
              }, 
                child: const ListTile(
                  leading: Icon(Icons.share_outlined),
                  title: Text('Share'),
                ),
              ),
              PopupMenuItem<Menu>(
                value: Menu.download,
                     onTap:(){
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
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
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
              }, 
                child: const ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Remove'),
                ),
              ),
              PopupMenuItem<Menu>(
                value: Menu.setting,
                     onTap:(){
                Navigator.of(context).pushNamed(  RouteGenerator.HomePages,);
              }, 
                child: const ListTile(
                  leading: Icon(Icons.visibility_outlined),
                  title: Text('Setting'),
                ),
              ),
            ];
          })
        ],
      ),
      drawer: const LeftDrawerWidget(),
      body: _currentPage,
      
      

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _changePage(index),
        type: BottomNavigationBarType.fixed, // allows more than 3 items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Product"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: "Lucky draw"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Team"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
      ),
    );
  }
}



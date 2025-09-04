import 'package:dalell/app/drawer.dart';
import 'package:dalell/app/pupupmenu.dart';
import 'package:dalell/home.dart';
import 'package:dalell/views/user/login_page.dart';
import 'package:flutter/material.dart';

class MarchentPage extends StatefulWidget {
  const MarchentPage({super.key});

  @override
  State<MarchentPage> createState() => _MarchentPage();
}


class _MarchentPage extends State<MarchentPage>
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
      ..add(const HomePage())
      //  ..add(const Dashboard())  
      ..add(const CategoriesPage())
      ..add( const TipsPage())
      ..add( const RFQPage())
      ..add(const UnstopProfilePage())
      ..add( const LoginPages ());
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
                    ? 'Order'
                    : _currentIndex == 3
                        ? 'Delevery'
                          : _currentIndex == 4
                        ? 'Order'
                        : 'Me'),
          //                TextField(
          // decoration: InputDecoration(
          //   hintText: 'What are you looking for...',
          //   border: InputBorder.none,
          //   hintStyle: TextStyle(color: Colors.grey),
          // ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_book_outlined),
          ),
          popUpMenuButtonForAll()
        ],
      ),
      
      drawer: const LeftDrawerWidget(),
      body: _currentPage,
    
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _changePage(index),
        type: BottomNavigationBarType.fixed, // allows more than 3 items
        items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: 'Tips'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messenger'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.add_business_rounded), label: "Business"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
   
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
      
    );
  }
    }
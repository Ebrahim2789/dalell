import 'package:dalell/app/drawer.dart';
import 'package:dalell/app/pupupmenu.dart';
import 'package:dalell/home.dart';
import 'package:dalell/product/view/categories_page.dart';
import 'package:dalell/views/user/bloc/auth_bloc.dart';
import 'package:dalell/views/user/bloc/auth_state.dart';
import 'package:dalell/views/user/login.dart';
import 'package:dalell/views/user/sign_in_option_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ..add(const TipsPage())
      ..add(const RFQPage())
      ..add(const UnstopProfilePage())
      ..add(const SignInPage());
    _currentPage = const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return AuthWarpper(
        child: Scaffold(
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
      body:
      _currentPage,
      
      
      //  BlocBuilder<AuthBloc, AuthState>(
      //   builder: (context, state) {
      //     if (state is AuthAuthenticated) {
      //       _currentPage=const HomePage();
            
            //  Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Welcome, ${state.user.email}!'),
            //       Text('Role: ${state.user.role}'),
            //     ],
            //   ),
            // );
        //   }
        //   else{
        //       _currentPage=const SignInPage();
        //   }
        //   return _currentPage;
        // },
        

      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _changePage(index),
        type: BottomNavigationBarType.fixed, // allows more than 3 items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline), label: 'Tips'),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: 'Messenger'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_business_rounded), label: "Business"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    ));
  }
}

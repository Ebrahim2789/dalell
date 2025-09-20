
import 'package:dalell/config/theme/theme_repository.dart';
import 'package:dalell/localizations/local.dart';
import 'package:dalell/models/setting.dart';
import 'package:dalell/order/views/delivery_list_view.dart';
import 'package:dalell/order/views/order_list_view.dart';
import 'package:dalell/product/view/product_list_view.dart';
import 'package:dalell/views/user/login.dart';
import 'package:flutter/material.dart';
import 'package:dalell/app/drawer.dart';
import 'package:dalell/app/pupupmenu.dart';
import 'package:dalell/models/homepage.dart';
import 'package:dalell/models/userprofile.dart';
import 'package:flutter_localization/flutter_localization.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key, required this.themeRepository});
      final ThemeRepository themeRepository ;

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
      ..add(const ProductListView())
      ..add(const OrderListView())
      ..add(const DeliveryListView())
      ..add(const Setting())
      ..add(const MePage());

    _currentPage = const Dashboard();

  }

  // ..add( const LuckyDrawPage())
  // ..add( const TeamPage())

  @override
  Widget build(BuildContext context) {
    
          return
           AuthWarpper(
            child: Scaffold(
              appBar: AppBar(
                title: Text(_currentIndex == 0
                    ? AppLocale.title.getString(context)
                    : _currentIndex == 1
                        ? 'Product'
                        : _currentIndex == 2
                            ? 'Order'
                            : _currentIndex == 3
                                ? 'Delevery'
                                : _currentIndex == 4
                                    ? 'Setting'
                                    : 'Me'),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu_book_outlined),
                  ),
                
                  popUpMenuButtonForHomes()
                ],
              ),
              drawer: const LeftDrawerWidget(),
              body: _currentPage,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) => _changePage(index),
                type: BottomNavigationBarType.fixed, // allows more than 3 items
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_bag), label: "Product"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: "Order"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.card_giftcard), label: "Delevery "),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_business_rounded),
                      label: "Business"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Me"),
                ],
                        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
              ),
            ),
          );
        
  }
}

// product_repository.dart

import 'package:dalell/order/views/address_list_view.dart';
import 'package:dalell/order/views/delivery_list_view.dart';
import 'package:dalell/order/views/order_list_view.dart';
import 'package:dalell/product/add_product_page.dart';
import 'package:dalell/product/view/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {
       WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainMenu(),
  ));
}



class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop Management")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Products"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductListView()),
            ),
          ),
          ListTile(
            title: Text("Orders"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OrderListView()),
            ),
          ),
          ListTile(
            title: Text("Deliveries"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DeliveryListView()),
            ),
          ),
  ListTile(
            title: Text("Address"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddressListView()),
            ),
          ),

          
        ],
      ),
    );
  }
}

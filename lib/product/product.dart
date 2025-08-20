// import 'package:flutter/material.dart';
// import 'package:dalell/order/orderconform.dart';

// void main() => runApp(const MasterPlanApp());

// class MasterPlanApp extends StatelessWidget {
//   const MasterPlanApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       themeMode: ThemeMode.light,
//       debugShowCheckedModeBanner: false,
    
//       home: const 
//       ProductEditorPage(),
//       // ProductOrderPage(),
      
      
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:dalell/product/add_product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Detail App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: const AddProductPage(),
    );
  }
}

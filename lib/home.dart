// import 'dart:convert';

// void main() {

//   consumeClosure();
//   printSwitch();
//   recordes();
//   classPlayground();
// }

// void callBackExample(void Function(String value) callback) {
//   callback('hello callback');
// }

// typedef NumberGetter = int Function();

// int powerOfTwo(NumberGetter getter) {
//   return getter() * getter();
// }

// void printSomething(String value) {
//   print(value);
// }

// void consumeClosure() {
//   int getFour() => 4;
//   final squred = powerOfTwo(getFour);
//   print(squred);
//   callBackExample(printSomething);
// }

// void printSwitch() {
//   int dayOfWeek = 7;
// var mayDay=switch(dayOfWeek){
//   1=>'monday',
//   2=>'tuesday',
//   _=>'sunday',
// };
// print(mayDay);
// }


// // records
// void recordes(){
//   // var person=(name:'abre',age:43);
// ({int a,int b}) add=(a:2,b:5);
//   print(add.a);
// var(String name,int age)=getPerson({'name':'abadalla','age':32});
// print('${name} is ${age} olds');

// }
// (String,int)getPerson(Map<String,dynamic>json){
//   return(json['name']as String ,json['age']as int);
// }

// class Name{
// final String first;
// final String last;
// Name(this.first,this.last);
// @override
//   String toString() {

//     return '$first,$last';
//   }
// }
// class OfficalName extends Name{
//   final String _title;
//   OfficalName(this._title,String first,String last):super(first,last);
//   @override
//   String toString() {
//  return '$_title $first,$last';
//   }

// }
// void classPlayground() {
// final name = OfficalName('Mr', 'Clark', 'Kent');

// final message = name.toString();
// print(message);

// final supern=Name("first", 'ali');
// print(supern.toString());
// }





// import 'package:flutter/material.dart';
// import 'package:dalell/pathdemo.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Bottom AppBar Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MainScreen(),
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     const CustomerScreen(),
//     const MerchantScreen(),
//     const HomeScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_currentIndex == 0
//             ? 'Customer'
//             : _currentIndex == 1
//                 ? 'Merchant'
//                 : 'Home'),
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.person),
//               onPressed: () {
//                 setState(() {
//                   _currentIndex = 0;
//                 });
//               },
//               color: _currentIndex == 0 ? Colors.blue : Colors.grey,
//             ),
//             IconButton(
//               icon: const Icon(Icons.store),
//               onPressed: () {
//                 setState(() {
//                   _currentIndex = 1;
//                 });
//               },
//               color: _currentIndex == 1 ? Colors.blue : Colors.grey,
//             ),
//             IconButton(
//               icon: const Icon(Icons.home),
//               onPressed: () {
//                 setState(() {
//                   _currentIndex = 2;
//                 });
//               },
//               color: _currentIndex == 2 ? Colors.blue : Colors.grey,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _currentIndex = 2; // Navigate to Home on FAB click
//           });
//         },
//         child: const Icon(Icons.home),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

// class CustomerScreen extends StatelessWidget {
//   const CustomerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Customer Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

// class MerchantScreen extends StatelessWidget {
//   const MerchantScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Merchant Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Home Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:dalell/container/container_layout.dart';
// import 'package:dalell/container/row_and_column_widet_demo.dart';

// class BottomBar extends StatefulWidget {
//   const BottomBar({super.key, required String title});

//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }

// class _BottomBarState extends State<BottomBar> {
//   List listpag = [];
//   late Widget _currentPage;

//   void _changePage(int selectedIndex) {
//     setState(() {
//       _currentPage = listpag[selectedIndex];
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     listpag
//       ..add(const BoxWithShadwo())
//       ..add(const ContainerWithBoxDecrotionWidth())
//       ..add(const ColumnWidetDemo());
//     _currentPage = const BoxWithShadwo();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bottom bar'),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: _currentPage,
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
//           BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarm'),
//           BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Star')
//         ],
//         onTap: (value) => _changePage(value),
//       ),
//     );
//   }
// }

// class TabBarViews extends StatefulWidget {
//   const TabBarViews({super.key, required String title});

//   @override
//   State<TabBarViews> createState() => _TabBarViewsState();
// }

// class _TabBarViewsState extends State<TabBarViews>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();

//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(_tabChanged);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     {
//       _tabController.dispose();
//     }
//   }

//   void _tabChanged() {
// // Check if Tab Controller index is changing, otherwise we get the notice twice
//     if (_tabController.indexIsChanging) {
//       // print('tabChanged: ${_tabController.index}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('TabBar'),
//         ),
//         body: SafeArea(
//           child: TabBarView(
//             controller: _tabController,
//             children: const [
//               BoxWithShadwo(),
//               ColumnWidetDemo(),
//               ContainerWithBoxDecrotionWidth(),
//             ],
//           ),
//         ),
//         bottomNavigationBar: newMethod());
//   }

//   SafeArea newMethod() {
//     return SafeArea(
//         child: TabBar(
//           controller: _tabController,
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.black26,
//           tabs: const [
//             Tab(
//               icon: Icon(Icons.cake),
//               text: 'Birthdays',
//             ),
//             Tab(
//               icon: Icon(Icons.sentiment_satisfied),
//               text: 'Gratitude',
//             ),
//             Tab(
//               icon: Icon(Icons.access_alarm),
//               text: 'Reminders',
//             ),
//           ],
//         ),
//       );
//   }
// }

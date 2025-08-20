// import 'package:flutter/material.dart';

// class RowWidetDemo extends StatefulWidget {
//   const RowWidetDemo({super.key});

//   @override
//   State<RowWidetDemo> createState() => _RowWidetDemoState();
// }

// class _RowWidetDemoState extends State<RowWidetDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70.0,
//       padding: const EdgeInsets.all(3),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(10),
//           topLeft: Radius.circular(10),
//         ),
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomLeft,
//           colors: [
//             Colors.orange,
//             Colors.cyanAccent,
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.lightGreen,
//               blurRadius: 10.0,
//               offset: Offset(0.0, 10.0)),
//         ],
//       ),
//       child: const Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Text('Row one '),
//           Padding(padding: EdgeInsets.all(16.0)),
//           Text('Row Two'),
//           Padding(padding: EdgeInsets.all(16.0)),
//           Text('Row Three'),
//         ],
//       ),
//     );
//   }
// }

// class ColumnWidetDemo extends StatefulWidget {
//   const ColumnWidetDemo({super.key});

//   @override
//   State<ColumnWidetDemo> createState() => _ColumnWidetDemoState();
// }

// class _ColumnWidetDemoState extends State<ColumnWidetDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 100.0,
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(10.0),
//               bottomLeft: Radius.circular(10.0),
//             ),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.grey,
//                 Colors.lightGreen.shade100,
//               ],
//             ),
//             boxShadow: const [
//               BoxShadow(
//                 blurRadius: 10.0,
//                 offset: Offset(0.0, 10.0),
//                 color: Colors.lightBlueAccent,
//               ),
//             ],
//           ),
//           child: const Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Text('Column One'),
//                 Divider(),
//                 Text('Column Two'),
//                 Divider(),
//                 Text('Column Three'),
//                 // Padding(padding: EdgeInsets.all(16.0)),
//               ],
//             ),
//           ),
//         ),
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Text('Row one '),
//             Text('Row Two'),
//             Text('Row Three'),
//           ],
//         ),
//         Container(
//           height: 20.0,
//         ),
//       ],
//     );
//   }
// }

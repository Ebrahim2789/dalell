// import 'package:flutter/material.dart';
// // Contains 'TargetPlatform'
// import 'dart:io' show Platform;

// class ListBuilder extends StatefulWidget {
//   const ListBuilder({super.key});

//   @override
//   State<ListBuilder> createState() => _ListBuilderState();
// }

// class _ListBuilderState extends State<ListBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     List<int> mylist = List.generate(10, (i) => i);

//     return BackButton(
//       onPressed: () {
//         final dailog = showSimplDialog(context);
//         print(dailog);
//       },
//     );
//   }
// }

// showDialogs(BuildContext context) {
//   return showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       barrierLabel: 'dsada',
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Example'),
//           content: const Text('Do you realy sure'),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           actions: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context, "false");
//                 },
//                 child: const Icon(Icons.one_k)),
//             IconButton(
//               onPressed: () {
//                 Navigator.pop(context, "true");
//               },
//               icon: const Icon(Icons.cancel),
//             ),
//           ],
//         );
//       });
// }

// showSimplDialog(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('exampl'),
//           children: [
//             SimpleDialogOption(
//               onPressed: () => Navigator.pop(context, "chocolate"),
//               child: const Text("Chocolate"),
//             ),
//             SimpleDialogOption(
//               onPressed: () => Navigator.pop(context, "apple"),
//               child: const Text("Apple"),
//             ),
//           ],
//         );
//       });
// }

// show(BuildContext context) {
//   return showBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           color: Colors.blueAccent,
//           height: 40,
//           child: const Center(
//               child: Text("BottomSheet",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ))),
//         );
//       });
// }




// void main(){

// print(Platform.isLinux);
// }
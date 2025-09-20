import 'package:dalell/config/theme/themedata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isRow;

  const AllContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.mainAxisAlignment,
      required this.crossAxisAlignment,
      this.isRow = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isRow == true
          ? _buildRowContainer(
              width, height, color, mainAxisAlignment, crossAxisAlignment)
          : _buildColumnContainer(
              width, height, color, mainAxisAlignment, crossAxisAlignment),
    );
  }
}

Widget _buildRowContainer(double width, double height, Color color,
    MainAxisAlignment main, CrossAxisAlignment cros) {
  return Container(
    width: width,
    height: height,
    color: color,
    child: const Text('data'),
  );
}

Widget _buildColumnContainer(double width, double height, Color color,
    MainAxisAlignment main, CrossAxisAlignment cros) {
  return Container(
    width: width,
    height: height,
    color: color,
    child: const Text('data'),
  );
}

class AllInOne extends StatefulWidget {
  const AllInOne({super.key});

  @override
  State<AllInOne> createState() => _AllInOneState();
}

class _AllInOneState extends State<AllInOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All container'),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WarpContainer(),
            PostionedWidget(),
          ],
        )

        //  const Stack(alignment: AlignmentDirectional.center, children: [
        //   AllContainer(
        //       width: 200,
        //       height: 200,
        //       color: Colors.greenAccent,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.start),
        //   AllContainer(
        //       width: 150,
        //       height: 150,
        //       color: Colors.deepOrange,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.start),
        //   AllContainer(
        //       width: 100,
        //       height: 00,
        //       color: Colors.blue,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.start),
        // ],),
        );
  }
}

Iterable<Widget> header(
    BuildContext context, double width, double height, Color color) {
  return [
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(0),
        color: color,
        width: width,
        height: height,
      ),
    ),
  ];
}

class WarpContainer extends StatelessWidget {
  const WarpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 4.0,
      children: [
        Chip(
          side: BorderSide(color: Colors.blueGrey, width: 10),
          avatar: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              'C',
              style: TextStyle(color: Colors.white),
            ),
          ),
          label: Text('Cupcake'),
          backgroundColor: Colors.white,
        ),
        Chip(
          side: BorderSide(color: Colors.blueGrey, width: 10),
          label: Text('Donut'),
          backgroundColor: Colors.white,
          avatar: CircleAvatar(
            backgroundColor: Colors.lightGreen,
            child: Text(
              'D',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Chip(
          side: BorderSide(color: Colors.blueGrey, width: 10),
          label: Text('Eclair'),
          backgroundColor: Colors.white,
          avatar: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'E',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Chip(
          side: BorderSide(color: Colors.blueGrey, width: 10),
          label: Text('Froyo'),
          backgroundColor: Colors.white,
          avatar: CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text(
              'F',
              style: TextStyle(color: Color.fromARGB(255, 141, 24, 24)),
            ),
          ),
        ),
        Chip(
          side: BorderSide(color: Colors.blueGrey, width: 10),
          label: Text('Gingerbread'),
          backgroundColor: Colors.white,
          avatar: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text(
              'G',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ),
        Chip(
          side: BorderSide(color: Colors.blueGrey, width: 10),
          label: Text('Honeycomb'),
          backgroundColor: Colors.white,
          avatar: CircleAvatar(
            radius: 100,
            foregroundColor: Colors.amber,
            backgroundColor: Colors.green,
            child: Text(
              'H',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

class PostionedWidget extends StatelessWidget {
  const PostionedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size(double.infinity, 256)),
      child: const Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
              child: Icon(
            Icons.calendar_today,
            size: 128,
            color: Colors.lightBlueAccent,
          )),
          Positioned(
              top: 50,
              right: 120,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.red,
              ))
        ],
      ),
    );
  }
}

class ContainerCardClass extends StatelessWidget {
  final Widget child;
  const ContainerCardClass({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeNotifeier = Provider.of<ThemeNotifier>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: themeNotifeier.isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
      ),
      child: child,
    );
  }
}

Widget containerCard(Widget child) {
  return ContainerCardClass(child: child);
}

Widget containerCard1(Widget child) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: child,
  );
}

Widget container1(Color colors) {
  return Container(
    height: 8,
    decoration: BoxDecoration(
      color: colors,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Widget containerWithConstaran(Widget child) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange[100]!, Colors.blue[50]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  );
}

Widget container2(Color colors, double progress) {
  return Container(
    height: 8,
    width: 200 * progress,
    decoration: BoxDecoration(
      color: colors,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Widget buildPrizeBox(String title, IconData icon) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        Icon(icon, size: 40, color: Colors.orange),
      ],
    ),
  );
}

Widget buildDrawBox() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('0',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text('Number of draws'),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text('Start'),
        ),
      ],
    ),
  );
}

Widget buildRecordRow(String user, String data, String reward) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(user, style: const TextStyle(color: Colors.white)),
      Text(data, style: const TextStyle(color: Colors.white)),
      Text(reward, style: const TextStyle(color: Colors.white)),
    ],
  );
}

import 'package:dalell/container/container.dart';
import 'package:dalell/routes/routes.dart';
import 'package:flutter/material.dart';



// End For demo

const grandisExtendedFont = "Grandis Extended";

// On color 80, 60.... those means opacity

const Color primaryColor = Color(0xFF7B61FF);

const MaterialColor primaryMaterialColor =
    MaterialColor(0xFF9581FF, <int, Color>{
  50: Color(0xFFEFECFF),
  100: Color(0xFFD7D0FF),
  200: Color(0xFFBDB0FF),
  300: Color(0xFFA390FF),
  400: Color(0xFF8F79FF),
  500: Color(0xFF7B61FF),
  600: Color(0xFF7359FF),
  700: Color(0xFF684FFF),
  800: Color(0xFF5E45FF),
  900: Color(0xFF6C56DD),
});

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color whileColor10 = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
// const Color greyColor80 = Color(0xFFC6C4CF);
// const Color greyColor60 = Color(0xFFD4D3DB);
// const Color greyColor40 = Color(0xFFE3E1E7);
// const Color greyColor20 = Color(0xFFF1F0F3);
// const Color greyColor10 = Color(0xFFF8F8F9);
// const Color greyColor5 = Color(0xFFFBFBFC);

const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

const pasNotMatchErrorText = "passwords do not match";
// Get screen size and orientation using MediaQuery

void GetScreenSizeAndOrientation(BuildContext context) async {
  final screenSize = MediaQuery.of(context).size;
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  final padding = MediaQuery.of(context).padding;
  final availableHeight = screenSize.height - padding.top - padding.bottom;
  // Responsive dimensions
  final searchBarWidth = screenSize.width * 0.9; // 90% of screen width
  final fontSize = screenSize.width * 0.04; // Responsive font size
  final iconSize = screenSize.width * 0.06; // Responsive icon size
  final listTileHeight = availableHeight * 0.1; // Responsive ListTile height
}

// Reusable widgets from before
class ProductCard extends StatelessWidget {
  final String imagePlaceholder;
  final String price;

  const ProductCard({
    super.key,
    required this.imagePlaceholder,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext contex, BoxConstraints sizes) {
      final sise = sizes.maxWidth < 400;
      final minsize = sizes.minWidth < 500;

      final double width = MediaQuery.of(context).size.width;

      final double height = MediaQuery.of(context).size.height;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          children: [
            Container(
              width: width / 3,
              height: height / 5,
              color: Colors.grey[300],
              child: minsize == true
                  ? Center(
                      child: Image.asset(
                      imagePlaceholder,
                      fit: BoxFit.cover,
                      height: height / 4,
                      width: width / 3,
                    ))
                  : Column(
                      children: [
                        Expanded(
                            child: Image.asset(
                          imagePlaceholder,
                          fit: BoxFit.cover,
                          height: height / 4,
                          width: width / 3,
                        )),
                        Text("data"),
                      ],
                    ),
            ),
            const SizedBox(height: 8),
            Text(price,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center),
          ],
        ),
      );
    });
  }
}

// Stats item widget
Widget statsItem(String title, String value) {
  return Column(
    children: [
      Text(title, style: const TextStyle(color: Colors.grey)),
      const SizedBox(height: 5),
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}


class ProductCrad extends StatelessWidget {

 final  List<String> title;
 final List<dynamic> data;
 final String imageUrl;

  const ProductCrad({super.key, required this.title, required this.data, required this.imageUrl});

  

  @override
  Widget build(BuildContext context) {
  Iterator<String> titles = title.iterator;
  List<dynamic> datas =[];
for(var dy in data){
  datas.add(dy);
}



  List<Widget> itemWidget = [];
   var valu=datas.map((v)=>v);

   

  while (titles.moveNext() && datas.iterator.moveNext()) {
   


    itemWidget.add(
      Text("${titles.current}:  ${valu.map((v)=>v)}"),
    );}
    
    return  GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.productDetails);
      },
      child: containerCard(
        Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Image.asset(
                    imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      color: Colors.red,
                      child: Text(
                        'p1',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // Details
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: itemWidget

              
                  ),
            ),
          ],
        ),
      ));
  }
}

// Product Card widget
Widget productCard(
  BuildContext context,
  String code,
  List<String> title,
  List<dynamic> data,
  String imageUrl, {

  required double progress,
}) {
  Iterator<String> titles = title.iterator;
  Iterator<dynamic> datas = data.iterator;

  List<Widget> itemWidget = [];
  while (titles.moveNext() && datas.moveNext()) {
    itemWidget.add(
      Text("${titles.current}:  ${datas.current.toString()}"),
    );
  }

  return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.productDetails);
      },
      child: containerCard(
        Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Image.asset(
                    imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      color: Colors.red,
                      child: Text(
                        code,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            // Details
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: itemWidget

              
                  ),
            ),
          ],
        ),
      ));
}

Widget textw() {
  return Text("data");
}

// Tab Button widget
Widget tabButton(String text, bool isSelected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? Colors.red : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(color: isSelected ? Colors.white : Colors.black),
    ),
  );
}

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }


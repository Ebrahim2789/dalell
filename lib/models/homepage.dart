import 'package:dalell/config/constant.dart';

import 'package:dalell/product/controller/product_controller.dart';

import 'package:flutter/material.dart';
import 'package:dalell/routes/routes.dart';

import '../product/models/product.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ProductController controller = ProductController();
  List<Product> products = [];

  void _loadProducts() async {
    final data = await controller.getAllProducts();

    if (data.isEmpty) {
      await controller.insertProduct(StaticData.products.first);
    }

    setState(() {
      products = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {

    super.dispose();
        products;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // AppBar
        appBar: AppBar(
          title:
              const Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
    
          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black87),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteGenerator.productEditorPage);
              },
            ),
          ],
        ),

        // Body
        body:
            LayoutBuilder(builder: (BuildContext contenx, BoxConstraints size) {
          List<ProductCard> pc = [];

          for (var p in products) {

            pc.add(ProductCard(
              imagePlaceholder: p.media.map((va)=>va.url).first,
              price: p.price.toString(),
            ));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top features row
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      featureItem(Icons.menu_book, "App"),
                      featureItem(Icons.card_giftcard, "Invite link"),
                      featureItem(Icons.monetization_on, "Bonus"),
                      featureItem(Icons.support_agent, "Services"),
                    ],
                  ),
                ),

                // Two large buttons
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: largeButton(
                            Icons.check_circle, "Check-in", Colors.blue),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: largeButton(
                            Icons.savings, "Asset appreciation", Colors.orange),
                      ),
                    ],
                  ),
                ),

                // Task bonus section
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Task bonus",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                taskBonusItem(
                  "assets/images/image21.jpg",
                  "This is the record of the meeting",
                ),
                taskBonusItem(
                  "assets/images/image1.jpg",
                  "We have also carried out a lot of work",
                ),

                // Introduction card
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Introduction to Dalell",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ProductCard(
                      imagePlaceholder: 'assets/images/image2.jpg',
                      price: 'ETB 14.23-44.26',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const ListTile(
                  title: Text(
                    'Top deals',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                ),

                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:[ ...pc.take(3),
                    
                    
                      
                      // ProductCard(
                      //   imagePlaceholder: 'assets/images/image2.jpg',
                      //   price: 'ETB 14.23-44.26',
                      // ),
                      // ProductCard(
                      //   imagePlaceholder: 'assets/images/image21.jpg',
                      //   price: 'ETB 14.23-44.26',
                      // ),
                    ],
                  ),
                ),

                // gridViewBuilder(products),
              ],
            ),
          );
        }));
  }
}

Widget gridViewBuilder(List<Product> products) {
  return LayoutBuilder(builder: (BuildContext contenx, BoxConstraints size) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 5),
        itemCount: products.length,
        itemBuilder: (contenx, index) {
          final product = products[index];
          return SizedBox(
              child: ProductCard(
            imagePlaceholder: product.media[index].url,
            price: product.price.toString(),
          ));
        });
  });
}

// Feature icon widget
Widget featureItem(IconData icon, String label) {
  return Column(
    children: [
      CircleAvatar(
        radius: 28,
        backgroundColor: Colors.orange.shade50,
        child: Icon(icon, color: Colors.orange, size: 28),
      ),
      const SizedBox(height: 5),
      Text(label, style: const TextStyle(fontSize: 12)),
    ],
  );
}

// Large button widget
Widget largeButton(IconData icon, String title, Color color) {
  return LayoutBuilder(builder: (BuildContext contex, BoxConstraints sizes) {
    final sise = sizes.maxWidth < 500;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color.withAlpha(100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ListTile(
          leading: Icon(
            icon,
            color: color,
            size: sise == false ? 30 : 20,
          ),
          title: Text(title,
              style: TextStyle(
                color: color,
                fontWeight: sise == false ? FontWeight.bold : FontWeight.w100,
              )),
          trailing: sise == false
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color),
                  onPressed: () {},
                  child: const Text("Go"),
                )
              : const Text("Go"),
        ),
      ),
    );
  });
}

// Task bonus card widget
Widget taskBonusItem(String imageUrl, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:
              Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () {},
          child: const Text("GO"),
        ),
      ),
    ),
  );
}

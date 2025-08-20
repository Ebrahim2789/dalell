// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:dalell/routes.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text("PRODUCT",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stats Card
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, blurRadius: 5)
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text("My products",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("Hold ", style: TextStyle(color: Colors.grey)),
                      Text("0",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                      Text(" piece", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      statsItem("Today Earnings", "0.00 Br"),
                      statsItem("Total Income", "40.00 Br"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.show_chart, color: Colors.orange),
                      SizedBox(width: 5),
                      Text("Total Investment amount",
                          style: TextStyle(color: Colors.grey)),
                      Spacer(),
                      Text("0.00 Br",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text("Transfer to Balance"),
                    onPressed: () {
                          Navigator.of(context).pushNamed(RouteGenerator.productOrderPage);
                 
                    },
                  ),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  tabButton("ALL", true),
                  const SizedBox(width: 10),
                  tabButton("LTA", false),
                ],
              ),
            ),

            // Product Cards
            productCard(
              context,
              "P1",
              "assets/images/image1.jpg",
              price: "490 Br",
              dailyIncome: "49 Br",
              period: "2 Day",
              limit: "1",
              progress: 0.62,
            ),

            productCard(
              context,
              "T1",
                     "assets/images/image1.jpg",
              price: "2380 Br",
              dailyIncome: "72 Br",
              period: "15 Day",
              limit: "1",
              progress: 0.65,
            ),
            productCard(
              context,
              "T2",
             "assets/images/image1.jpg",
              price: "7950 Br",
              dailyIncome: "246 Br",
              period: "32 Day",
              limit: "1",
              progress: 0.45,
            ),
          ],
        ),
      ),
    );
  }

  // Stats item widget
  static Widget statsItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Tab Button widget
  static Widget tabButton(String text, bool isSelected) {
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

  // Product Card widget
  static Widget productCard(
    BuildContext context,
    String code,
    String imageUrl, {
    required String price,
    required String dailyIncome,
    required String period,
    required String limit,
    required double progress,
  }) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(RouteGenerator.productDetails);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
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
                  children: [
                    Text("Price: $price",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("Daily income: $dailyIncome"),
                    Text("Contract period: $period"),
                    Text("Purchase limit: $limit"),
                    const SizedBox(height: 5),

                    // Progress bar
                    Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          height: 8,
                          width: 200 * progress,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text("${(progress * 100).toInt()}%",
                        style:
                            const TextStyle(color: Colors.red, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Promo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ProductPromoPage(),
    );
  }
}





class ProductPromoPage extends StatelessWidget {
  const ProductPromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('xAI'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ProductPromo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search to reviews, profiles, groups, ...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/image2.jpg',
                  fit: BoxFit.cover,
                  height: 100,
                ),
                title: const Text('Product Promo 1'),
                subtitle: const Text('Promo details here...'),
                trailing:
                    const Icon(Icons.favorite_border, color: Colors.green),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/image2.jpg',
                  height: 100,
                ),
                title: const Text('Product Promo 2'),
                subtitle: const Text('Promo details here...'),
                trailing:
                    const Icon(Icons.favorite_border, color: Colors.green),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You might like',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/image2.jpg',
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                      const Text('Tomato', style: TextStyle(fontSize: 16)),
                      const Text('Price: \$2.99',
                          style: TextStyle(color: Colors.green)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart_checkout))
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/image2.jpg',
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                      const Text('Noodles', style: TextStyle(fontSize: 16)),
                      const Text('Price: \$3.49',
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

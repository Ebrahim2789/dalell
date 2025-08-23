
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductManagerPage(),
      
    );
  }
}

class ProductManagerPage extends StatelessWidget {
  const ProductManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductManager'),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Product search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: const [
                ProductItem(
                  title: 'Grapes Mature',
                  subtitle: 'classified',
                  imageUrl: 'https://via.placeholder.com/50',
                ),
                ProductItem(
                  title: 'Grapes Mature',
                  subtitle: 'stock',
                  imageUrl: 'https://via.placeholder.com/50',
                ),
                ProductItem(
                  title: 'Grapes Mature',
                  subtitle: 'stock',
                  imageUrl: 'https://via.placeholder.com/50',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Add'),
            ),
          ),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analyze'),
              BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Shopping'),
            ],
            currentIndex: 0,
            onTap: (index) {},
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const ProductItem({super.key, required this.title, required this.subtitle, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: const Text('Edit'),
        ),
      ),
    );
  }
}

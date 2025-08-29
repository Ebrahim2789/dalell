import 'package:flutter/material.dart';

class Product {
  final String name;
  final String brand;
  final String category;
  final List<String> media; // List of image URLs
  final Map<String, String>
      attributes; // e.g., {'Material': 'Cotton', 'Weight': '200g'}
  final List<String> options; // e.g., ['Small', 'Medium', 'Large']

  Product({
    required this.name,
    required this.brand,
    required this.category,
    required this.media,
    required this.attributes,
    required this.options,
  });
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  // Static data for products
  static final List<Product> products = [
    Product(
      name: 'Wireless Headphones',
      brand: 'Sony',
      category: 'Electronics',
      media: [
        'assets/images/image3.jpg',
        'assets/images/image5.jpg',
      ],
      attributes: {
        'Battery Life': '20 hours',
        'Color': 'Black',
        'Connectivity': 'Bluetooth 5.0',
      },
      options: ['Over-Ear', 'In-Ear'],
    ),
    Product(
      name: 'Running Shoes',
      brand: 'Nike',
      category: 'Footwear',
      media: [
        'assets/images/image2.jpg',
        'assets/images/image2.jpg',
      ],
      attributes: {
        'Material': 'Mesh',
        'Sole': 'Rubber',
        'Weight': '300g',
      },
      options: ['Size 8', 'Size 9', 'Size 10'],
    ),
    Product(
      name: 'Smartphone',
      brand: 'Apple',
      category: 'Electronics',
      media: [
        'assets/images/image2.jpg',
        'assets/images/image2.jpg',
      ],
      attributes: {
        'Screen Size': '6.1 inches',
        'Storage': '128GB',
        'Camera': '12MP',
      },
      options: ['Silver', 'Black', 'Gold'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Repository'),
        centerTitle: true,
        elevation: 4.0, // Shadow for AppBar
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image (using first media URL)
                  Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(product.media[0]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 10.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Text(
                              'Brand: ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              product.brand,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 16.0),
                            Text(
                              'Category: ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              product.category,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Attributes:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        ...product.attributes.entries.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Text('• ${entry.key}: ${entry.value}'),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Options:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: product.options
                              .map(
                                (option) => Chip(
                                  label: Text(option),
                                  backgroundColor: Colors.blue.shade100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side:
                                        BorderSide(color: Colors.blue.shade300),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Media:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 100.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.media.length,
                            itemBuilder: (context, mediaIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withAlpha(128),
                                        blurRadius: 5.0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],

                                 
                                    image: DecorationImage(
                                      image: AssetImage(product.media[mediaIndex]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Repository',
      theme: ThemeData(
  
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: const CardThemeData(
          elevation: 8.0, // Adding shadow elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          bodyMedium: TextStyle(fontSize: 16.0),
          bodySmall: TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
      ),
      home: const ProductListScreen(),
    );
  }
}

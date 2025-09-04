import 'package:dalell/config/theme/themedata.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Brand {
  final String id;
  final String name;
  final String logoUrl;

  Brand({required this.id, required this.name, required this.logoUrl});
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});
}



class Media {
  final String id;
  final String url;
  final String type; // e.g., 'image', 'video'

  Media({required this.id, required this.url, required this.type});
}

class ProductAttribute {
  final String name;
  final String value;

  ProductAttribute({required this.name, required this.value});
}

class ProductOption {
  final String name;
  final List<String> values;

  ProductOption({required this.name, required this.values});
}
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final Brand brand;
  final Category category;
  final List<Media> media;
  final List<ProductAttribute> attributes;
  final List<ProductOption> options;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.brand,
    required this.category,
    required this.media,
    required this.attributes,
    required this.options,
  });
}


class StaticData {
  static final List<Product> products = [
    Product(
      id: '1',
      name: 'Wireless Headphones',
      description: 'High-quality wireless headphones with noise cancellation.',
      price: 199.99,
      brand: Brand(id: 'b1', name: 'SoundMax', logoUrl: 'assets/images/image2.jpg'),
      category: Category(id: 'c1', name: 'Electronics'),
      media: [
        Media(id: 'm1', url:  'assets/images/image2.jpg', type: 'image'),
        Media(id: 'm2', url:  'assets/images/image2.jpg', type: 'image'),
      ],
      attributes: [
        ProductAttribute(name: 'Color', value: 'Black'),
        ProductAttribute(name: 'Battery Life', value: '20 hours'),
      ],
      options: [
        ProductOption(name: 'Size', values: ['Small', 'Medium', 'Large']),
        ProductOption(name: 'Connectivity', values: ['Bluetooth', 'Wired']),
      ],
    ),
    Product(
      id: '2',
      name: 'Smart Watch',
      description: 'Sleek smartwatch with fitness tracking and notifications.',
      price: 299.99,
      brand: Brand(id: 'b2', name: 'TechTrend', logoUrl: 'assets/images/image2.jpg',),
      category: Category(id: 'c2', name: 'Wearables'),
      media: [
        Media(id: 'm3', url:  'assets/images/image2.jpg', type: 'image'),
      ],
      attributes: [
        ProductAttribute(name: 'Display', value: 'AMOLED'),
        ProductAttribute(name: 'Water Resistance', value: 'IP68'),
      ],
      options: [
        ProductOption(name: 'Strap Color', values: ['Black', 'Blue', 'Red']),
      ],
    ),
  ];
}
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: product.media.first.url,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.brand.name,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.teal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AttributeChip extends StatelessWidget {
  final String label;
  final String value;

  const AttributeChip({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.teal.withAlpha(100),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.teal, width: 1),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 12, color: Colors.teal, fontWeight: FontWeight.w500),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: StaticData.products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: StaticData.products[index]);
        },
      ),
    );
  }
}


class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(128),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CachedNetworkImage(
                imageUrl: product.media.first.url,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Brand: ${product.brand.name}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  Text(
                    'Category: ${product.category.name}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Attributes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    children: product.attributes
                        .map((attr) => AttributeChip(label: attr.name, value: attr.value))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Options',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...product.options.map((option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.name,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Wrap(
                              children: option.values
                                  .map((value) => AttributeChip(label: option.name, value: value))
                                  .toList(),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: appTheme(),
      home: const HomeScreen(),
    );
  }
}
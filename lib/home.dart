import 'package:dalell/config/theme/themedata.dart';
import 'package:dalell/product/models/brand.dart';
import 'package:dalell/product/models/category.dart';
import 'package:dalell/product/models/media.dart';
import 'package:dalell/product/models/product.dart';
import 'package:dalell/product/repositories/product_media_repository.dart';
import 'package:dalell/product/repositories/product_repository.dart';
import 'package:dalell/config/theme/inputdecoration.dart';
import 'package:flutter/material.dart';





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
      home: const ProductListScreen(),
    );
  }
}


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  ProductListScreenState createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _mediaPathController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final productRepo = ProductRepository();
  final prodmeda = ProductMediaRepository();

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _mediaPathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWide = screenSize.width > 700;
    final fontSize = screenSize.width * 0.04;
    final iconSize = screenSize.width * 0.06;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(fontSize: fontSize * 1.2),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 48.0 : 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search, size: iconSize),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintStyle: TextStyle(fontSize: fontSize),
              ),
              style: TextStyle(fontSize: fontSize),
            ),
          ),
          // Product List/Grid
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: productRepo.getAllProductsWithMedia(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final products = snapshot.data!
                    .where((product) => product.name
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                    .toList();
                if (products.isEmpty) {
                  return Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: fontSize),
                    ),
                  );
                }
                // Use GridView for wide screens, ListView for narrow
                if (isWide) {
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 48.0 : 16.0, vertical: 8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenSize.width ~/ 350, // ~350px per card
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _ProductTile(
                        product: product,
                        fontSize: fontSize,
                        iconSize: iconSize,
                        onDelete: () async {
                          await productRepo.deleteProduct(product.id!);
                          setState(() {});
                        },
                        onTap: () async {
                          final media =
                              await prodmeda.getMediaByProduct(product.id!);
                          _showProductDialog(context, product, media, fontSize, screenSize);
                        },
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _ProductTile(
                        product: product,
                        fontSize: fontSize,
                        iconSize: iconSize,
                        onDelete: () async {
                          await productRepo.deleteProduct(product.id!);
                          setState(() {});
                        },
                        onTap: () async {
                          final media =
                              await prodmeda.getMediaByProduct(product.id!);
                          _showProductDialog(context, product, media, fontSize, screenSize);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: Icon(Icons.add, size: iconSize),
      ),
    );
  }

  void _showProductDialog(BuildContext context, Product product, List<Media> media, double fontSize, Size screenSize) {
    final availableHeight = screenSize.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          product.name,
          style: TextStyle(fontSize: fontSize * 1.1),
        ),
        content: Container(
          constraints: BoxConstraints(
            maxWidth: screenSize.width * 0.8,
            maxHeight: availableHeight * 0.5,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: media
                  .map((m) => Text(
                        'Media: ${m.url}',
                        style: TextStyle(fontSize: fontSize),
                      ))
                  .toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.04;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Product',
          style: TextStyle(fontSize: fontSize * 1.1),
        ),
        content: SizedBox(
          width: screenSize.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: fontSize),
              ),
              TextField(
                controller: _mediaPathController,
                decoration: InputDecoration(
                  labelText: 'Media Path (e.g., image URL)',
                  labelStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final product = Product(
                name: _nameController.text,
                price: double.parse(_priceController.text),
                description: '',
                brand: Brand(name: 'name', logoUrl: 'logoUrl'),
                category: Category(name: 'name'),
              );
              final productId = await productRepo.insertProduct(product);
              await prodmeda.insertMedia(Media(
                productid: productId,
                url: _mediaPathController.text,
                type: 'image',
              ));
              _nameController.clear();
              _priceController.clear();
              _mediaPathController.clear();
              Navigator.pop(context);
              setState(() {});
            },
            child: Text(
              'Add',
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}

// Responsive product tile for both grid and list
class _ProductTile extends StatelessWidget {
  final Product product;
  final double fontSize;
  final double iconSize;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const _ProductTile({
    required this.product,
    required this.fontSize,
    required this.iconSize,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        title: Text(
          product.name,
          style: TextStyle(fontSize: fontSize),
        ),
        subtitle: Text(
          'Price: \$${product.price}',
          style: TextStyle(fontSize: fontSize * 0.9),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, size: iconSize),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 700;
    final cardWidth = isWide ? 200.0 : 130.0;
    final fontSize = isWide ? 20.0 : 16.0;
    final sectionTitleSize = isWide ? 22.0 : 18.0;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'What are you looking for...',
            focusedBorder: focusedOutlineInputBorder,
            enabledBorder: outlineInputBorder,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isWide ? 32.0 : 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: isWide ? 16.0 : 8.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 16,
                  runSpacing: 8,
                  children: const [
                    Text('Products',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Manufacturers',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Regional supplies',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.all(isWide ? 24.0 : 16.0),
                child: Text(
                  'For your business',
                  style: TextStyle(
                      fontSize: sectionTitleSize, fontWeight: FontWeight.bold),
                ),
              ),
              // Responsive business action buttons
              Padding(
                padding: EdgeInsets.only(bottom: isWide ? 24.0 : 16.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _BusinessActionButton(
                      label: 'All categories',
                      color: Colors.orange,
                      onTap: () => Navigator.pushNamed(context, '/categories'),
                      width: cardWidth,
                    ),
                    _BusinessActionButton(
                      label: 'Request for Quotation',
                      color: Colors.blue[800]!,
                      onTap: () => Navigator.pushNamed(context, '/rfq'),
                      width: cardWidth,
                    ),
               
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  'Top deals',
                  style: TextStyle(
                      fontSize: sectionTitleSize, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward),
              ),
              SizedBox(
                height: isWide ? 260 : 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductCard(
                      imagePlaceholder: 'assets/images/image1.jpg',
                      price: 'ETB 630.60-\n1,975.55',
                    ),
                    ProductCard(
                      imagePlaceholder: 'assets/images/image6.jpg',
                      price: 'ETB 442.53-\n742.81',
                    ),
                    ProductCard(
                      imagePlaceholder: 'assets/images/imagex1.jpg',
                      price: 'ETB 2,607.7\n2,844.79',
                    ),
                  ]
                      .map((card) => SizedBox(
                            width: cardWidth,
                            child: card,
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(
                  'New arrivals',
                  style: TextStyle(
                      fontSize: sectionTitleSize, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward),
              ),
              SizedBox(
                height: isWide ? 260 : 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProductCard(
                      imagePlaceholder: 'assets/images/image21.jpg',
                      price: 'ETB 14.23-44.26',
                    ),
                    ProductCard(
                      imagePlaceholder: 'assets/images/image5.jpg',
                      price: 'ETB 3,081.86-\n5,016.21',
                    ),
                    ProductCard(
                      imagePlaceholder: 'assets/images/image3.jpg',
                      price: 'ETB 7.91-11.4',
                    ),
                  ]
                      .map((card) => SizedBox(
                            width: cardWidth,
                            child: card,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Responsive business action button widget
class _BusinessActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final double width;

  const _BusinessActionButton({
    required this.label,
    required this.color,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}


class UnstopProfilePage extends StatelessWidget {
  const UnstopProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unstop'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.message), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.work), onPressed: () {}),
        ],
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Text('Avatar'),
                  ),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.visibility), onPressed: () {}),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Abraham Abdo\n@Abrahim_',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Haramaya University, Dire Dawa, Ethiopia'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Resume'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Edit Profile'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Create your Resume'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                color: Colors.yellow,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('0\nProfile Views'),
                      Text(
                          'Increase your profile Engagement by 3X by filling the details below'),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Accomplishments +'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Rankings How it works?'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Points'),
                  Text('0 >'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Badges'),
                  Text('3 >'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class RFQPage extends StatelessWidget {
  const RFQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request for Quotation'),
        backgroundColor: Colors.orange[900],
      ),
      backgroundColor: Colors.indigo[900],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Get quotes for your custom request\nAccurate supplier matching, fast price comparison',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Requests for Quotation',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  RFQCategoryCard(
                      title: 'Design customization',
                      imagePlaceholder: 'Gear part'),
                  RFQCategoryCard(
                      title: 'Logo customization', imagePlaceholder: 'T-shirt'),
                  RFQCategoryCard(
                      title: 'Bundling customization', imagePlaceholder: 'Box'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Learn about RFQ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Tell us what you need',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        'Upload an image, or enter keywords. For example, "100pcs bear toys, see upload for design reference."',
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  maxLines: 3,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Easily generate an RFQ with AI',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('Write RFQ details'),
              ),
            ),
            Container(
              color: Colors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Post a request from these recommended products',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  RFQProductCard(
                    suppliers: '1,292 suppliers providing',
                    title: 'Basketball Style Shoes',
                    customization:
                        'Customization: Color, Outsole Material, Upper Material, Lining...',
                    imagePlaceholder: 'Shoes',
                  ),
                  RFQProductCard(
                    suppliers: '4,542 suppliers providing',
                    title: 'Mobile Phone Holders',
                    customization:
                        'Customization: Material, Customized Logo, Customized...',
                    imagePlaceholder: 'Phone holder',
                  ),
                  RFQProductCard(
                    suppliers: '29,872 suppliers providing',
                    title: 'Men\'s T-Shirts',
                    customization: '',
                    imagePlaceholder: 'T-shirts',
                  ),
                  RFQProductCard(
                    suppliers: '1,826 suppliers providing',
                    title: 'Reflective Safety Clothing',
                    customization: '',
                    imagePlaceholder: 'Clothing',
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

class RFQCategoryCard extends StatelessWidget {
  final String title;
  final String imagePlaceholder;

  const RFQCategoryCard(
      {super.key, required this.title, required this.imagePlaceholder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: Center(child: Text(imagePlaceholder)),
          ),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class RFQProductCard extends StatelessWidget {
  final String suppliers;
  final String title;
  final String customization;
  final String imagePlaceholder;

  const RFQProductCard({
    super.key,
    required this.suppliers,
    required this.title,
    required this.customization,
    required this.imagePlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: Center(child: Text(imagePlaceholder)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(suppliers, style: const TextStyle(color: Colors.grey)),
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(customization,
                        style: const TextStyle(
                            color: Colors.orange, fontSize: 12)),
                    const Text('Get quotes now',
                        style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<SubCategoryItem> subItems;

  const CategorySection({
    super.key,
    required this.title,
    required this.subItems,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: subItems,
            ),
          ),
        ],
      ),
    );
  }
}

class SubCategoryItem extends StatelessWidget {
  final String name;
  final String imagePlaceholder;

  const SubCategoryItem({
    super.key,
    required this.name,
    required this.imagePlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[300],
          child: Text(imagePlaceholder,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(name,
            style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
      ],
    );
  }
}

class ProductInspirationCard extends StatelessWidget {
  final String imagePlaceholder;
  final String price;
  final String minOrder;

  const ProductInspirationCard({
    super.key,
    required this.imagePlaceholder,
    required this.price,
    required this.minOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
            color: Colors.grey[300],
            child: Center(
                child: Text(imagePlaceholder, textAlign: TextAlign.center)),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(minOrder, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
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
        child: Column(
          children: [
            Container(
              width: width / 3,
              height: height / 7,
              color: Colors.grey[300],
              child: minsize == true
                  ? Center(child: Image.asset(imagePlaceholder)

                      // Text(imagePlaceholder, textAlign: TextAlign.center)

                      )
                  : Column(
                      children: [
                        Expanded(
                          child: Image.asset(imagePlaceholder),
                        ),
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

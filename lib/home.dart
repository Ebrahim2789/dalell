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

  final productRepo= ProductRepository();

  final prodmeda = ProductMediaRepository();

  String _searchQuery = '';
// final  pro= staticdatas;
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
    // Get screen size and orientation using MediaQuery
    final screenSize = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final padding = MediaQuery.of(context).padding;
    final availableHeight = screenSize.height - padding.top - padding.bottom;

    // Responsive dimensions
    final searchBarWidth = screenSize.width * 0.9; // 90% of screen width
    final fontSize = screenSize.width * 0.04; // Responsive font size
    final iconSize = screenSize.width * 0.06; // Responsive icon size
    final listTileHeight = availableHeight * 0.1; // Responsive ListTile height

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(fontSize: fontSize * 1.2), // Responsive title size
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            width: searchBarWidth,
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.01,
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
          // Product List
          Expanded(
            child: FutureBuilder<List<Product>>(

              //  future:  pro,
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
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      height: listTileHeight,
                      margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.05,
                        vertical: screenSize.height * 0.005,
                      ),
                      child: ListTile(
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
                          onPressed: () async {
                            await productRepo.deleteProduct(product.id!);
                            setState(() {});
                          },
                        ),
                        onTap: () async {
                          final media =
                              await prodmeda.getMediaByProduct(product.id!);
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
                                              style:
                                                  TextStyle(fontSize: fontSize),
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
                        },
                      ),
                    );
                  },
                );
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
                brand:Brand(name: 'name', logoUrl: 'logoUrl') ,
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





class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'What are you looking for...',
            focusedBorder: focusedOutlineInputBorder,
            enabledBorder: outlineInputBorder,
            hintStyle: TextStyle(color: Colors.grey),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Products',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Manufacturers',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Regional supplies',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'For your business',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/categories');
                  },
                  child: Container(
                    width: 110,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'All categories',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/rfq');
                  },
                  child: Container(
                    width: 110,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Request for Quotation',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Source in Europe',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
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
                children: const [
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
                ],
              ),
            ),
            const SizedBox(height: 16),
            const ListTile(
              title: Text(
                'New arrivals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
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
                ],
              ),
            ),
          ],
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

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'For you',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const CategorySection(
              title: 'Home & Garden',
              subItems: [
                SubCategoryItem(
                    name: 'Wedding Dresses', imagePlaceholder: 'Wedding dress'),
                SubCategoryItem(
                    name: 'Electric Cars', imagePlaceholder: 'Electric car'),
                SubCategoryItem(name: 'Drones', imagePlaceholder: 'Drone'),
              ],
            ),
            const CategorySection(
              title: 'Sports & Entertainment',
              subItems: [
                SubCategoryItem(name: 'Tractors', imagePlaceholder: 'Tractor'),
                SubCategoryItem(
                    name: 'Smart Watches', imagePlaceholder: 'Smart watch'),
                SubCategoryItem(
                    name: 'Vending Machines',
                    imagePlaceholder: 'Vending machine'),
              ],
            ),
            // Additional categories can be added similarly
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Get product inspiration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const ProductInspirationCard(
              imagePlaceholder: 'Car parts',
              price: 'ETB 268,674.29-\n316,087.40',
              minOrder: 'Min. order: 1 set',
            ),
            const ProductInspirationCard(
              imagePlaceholder: 'Polo shirts',
              price: 'ETB 2,844.79-3,951.10',
              minOrder: 'Min. order: 30 pieces',
            ),
            const ProductInspirationCard(
              imagePlaceholder: 'Boots',
              price: 'ETB 4,221.35-5,812.85',
              minOrder: 'Min. order: 2 pairs',
            ),
            const ProductInspirationCard(
              imagePlaceholder: 'Pink dress',
              price: 'ETB 33,568.49',
              minOrder: 'Min. order: 2 pieces',
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

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Following', style: TextStyle(fontSize: 16)),
                  Text('Recommended',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hot topics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  TopicCard(
                    imagePlaceholder: 'Selected global new products',
                    hashtag: '#Selected global new products',
                    views: '779',
                  ),
                  TopicCard(
                    imagePlaceholder: 'Find your high-quality products',
                    hashtag: '#Find your high-quality products',
                    views: '8.6k',
                  ),
                  TopicCard(
                    imagePlaceholder: 'Unique novelties',
                    hashtag: '#Unique novelties',
                    views: '25.4k',
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Get inspired',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const VideoCard(
              thumbnailPlaceholder: 'Shoes',
              duration: '00:25',
              title: 'Fashionable appearance walk on your style#shoes #soft',
              views: '1.7k',
            ),
            const VideoCard(
              thumbnailPlaceholder: 'What is Alibaba.com?',
              duration: '01:49',
              title: 'The official guidebook to Alibaba.com',
              views: '4.3M',
            ),
            const VideoCard(
              thumbnailPlaceholder: 'Body slimming',
              duration: '00:40',
              title: '#emsculpt #bodyshape #Body SlimmingPro',
              views: '57.7k',
            ),
            const VideoCard(
              thumbnailPlaceholder: 'Muslim dress',
              duration: '00:18',
              title: 'Muslim dress show',
              views: '',
            ),
            const VideoCard(
              thumbnailPlaceholder: 'Earphones',
              duration: '01:00',
              title: 'Pro2 gen earphones',
              views: '',
            ),
          ],
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String imagePlaceholder;
  final String hashtag;
  final String views;

  const TopicCard({
    super.key,
    required this.imagePlaceholder,
    required this.hashtag,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(child: Text(imagePlaceholder)),
            ),
            Text(hashtag, style: const TextStyle(fontSize: 12)),
            Text(views, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String thumbnailPlaceholder;
  final String duration;
  final String title;
  final String views;

  const VideoCard({
    super.key,
    required this.thumbnailPlaceholder,
    required this.duration,
    required this.title,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            Center(child: Text(thumbnailPlaceholder)),
            Positioned(
              bottom: 8,
              left: 8,
              child:
                  Text(duration, style: const TextStyle(color: Colors.white)),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text(views, style: const TextStyle(color: Colors.white)),
            ),
            Positioned(
              bottom: 30,
              left: 8,
              child: Text(title, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

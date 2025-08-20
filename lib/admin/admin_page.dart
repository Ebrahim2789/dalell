
import 'package:flutter/material.dart';
import 'package:dalell/product/categories_page.dart';
import 'package:dalell/views/login_page.dart';
import 'package:dalell/admin/tips_page.dart';
import 'package:dalell/views/profile_page.dart';
import 'package:dalell/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' UI ',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
      routes: {
        '/categories': (context) => const CategoriesPage(),
        '/rfq': (context) => const RFQPage(),
        '/tips': (context) => const TipsPage(),
        '/login': (context) => const LoginPages(),
        '/unstop': (context) => const ProfilePage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'What are you looking for...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
                  Navigator.of(context).pushNamed(RouteGenerator.productEditorPage);
            },
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
                  Text('Products', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Manufacturers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Regional supplies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: 'Tips'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messenger'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Alibaba'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/tips');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/LoginPage'); // Assuming My Alibaba leads to login
          }

          else if (index == 3) {
            Navigator.pushNamed(context, '/unstop'); // Assuming My Alibaba leads to login
          }
          
          // Handle other tabs as needed
        },
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.indigo[900],
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
                  RFQCategoryCard(title: 'Design customization', imagePlaceholder: 'Gear part'),
                  RFQCategoryCard(title: 'Logo customization', imagePlaceholder: 'T-shirt'),
                  RFQCategoryCard(title: 'Bundling customization', imagePlaceholder: 'Box'),
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
                    hintText: 'Upload an image, or enter keywords. For example, "100pcs bear toys, see upload for design reference."',
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                    customization: 'Customization: Color, Outsole Material, Upper Material, Lining...',
                    imagePlaceholder: 'Shoes',
                  ),
                  RFQProductCard(
                    suppliers: '4,542 suppliers providing',
                    title: 'Mobile Phone Holders',
                    customization: 'Customization: Material, Customized Logo, Customized...',
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

  const RFQCategoryCard({super.key, required this.title, required this.imagePlaceholder});

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
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(customization, style: const TextStyle(color: Colors.orange, fontSize: 12)),
                    const Text('Get quotes now', style: TextStyle(color: Colors.blue)),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            color: Colors.grey[300],
            
            child: Center(child: 
            Image.asset(imagePlaceholder)
            
            // Text(imagePlaceholder, textAlign: TextAlign.center)
            
            ),
          ),
          const SizedBox(height: 8),
          Text(price, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ],
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
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          child: Text(imagePlaceholder, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
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
            child: Center(child: Text(imagePlaceholder, textAlign: TextAlign.center)),
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

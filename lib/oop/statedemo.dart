import 'package:flutter/material.dart';
import 'package:dalell/views/user/profile_page.dart';

class StateDemo extends StatefulWidget {
  const StateDemo({super.key});

  @override
  State<StateDemo> createState() => _StateDemoState();
}

class _StateDemoState extends State<StateDemo> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incurment() {
    setState(() {
      _counter++;
    });

    void decriment() {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [TextButton(onPressed: () {}, child: Text('$_counter'))],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incurment();
        },
        child: const Icon(Icons.add),
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
      title: 'Alibaba UI Clone',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
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
            icon: const Icon(Icons.more_vert),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
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
                Container(
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
                    imagePlaceholder: 'Drone toy',
                    price: 'ETB 630.60-\n1,975.55',
                  ),
                  ProductCard(
                    imagePlaceholder: 'Woman with box',
                    price: 'ETB 442.53-\n742.81',
                  ),
                  ProductCard(
                    imagePlaceholder: 'Soldering tool',
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
                    imagePlaceholder: 'TikTok NFC card',
                    price: 'ETB 14.23-44.26',
                  ),
                  ProductCard(
                    imagePlaceholder: 'DeWalt circular saw',
                    price: 'ETB 3,081.86-\n5,016.21',
                  ),
                  ProductCard(
                    imagePlaceholder: 'Rolled item',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'For you',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CategorySection(
              title: 'Home & Garden',
              subItems: [
                SubCategoryItem(name: 'Wedding Dresses', imagePlaceholder: 'Wedding dress'),
                SubCategoryItem(name: 'Electric Cars', imagePlaceholder: 'Electric car'),
                SubCategoryItem(name: 'Drones', imagePlaceholder: 'Drone'),
              ],
            ),
            CategorySection(
              title: 'Sports & Entertainment',
              subItems: [
                SubCategoryItem(name: 'Tractors', imagePlaceholder: 'Tractor'),
                SubCategoryItem(name: 'Smart Watches', imagePlaceholder: 'Smart watch'),
                SubCategoryItem(name: 'Vending Machines', imagePlaceholder: 'Vending machine'),
              ],
            ),
            // Add more category sections as per screenshot (Beauty, Jewelry, etc.)
            // For brevity, only a few are implemented; extend similarly.
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Get product inspiration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ProductInspirationCard(
              imagePlaceholder: 'Car parts',
              price: 'ETB 268,674.29-\n316,087.40',
              minOrder: 'Min. order: 1 set',
            ),
            ProductInspirationCard(
              imagePlaceholder: 'Polo shirts',
              price: 'ETB 2,844.79-3,951.10',
              minOrder: 'Min. order: 30 pieces',
            ),
            ProductInspirationCard(
              imagePlaceholder: 'Boots',
              price: 'ETB 4,221.35-5,812.85',
              minOrder: 'Min. order: 2 pairs',
            ),
            ProductInspirationCard(
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
            child: Center(child: Text(imagePlaceholder, textAlign: TextAlign.center)),
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
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        
          SizedBox(
            
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
      child: Wrap(
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

import 'package:dalell/container/container.dart';
import 'package:dalell/oop/statedemo.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

List<CategorySection> categorySection = [
  CategorySection(
    title: 'Home & Garden',
    subItems: [
      SubCategoryItem(
          name: 'Wedding Dresses', imagePlaceholder: 'Wedding dress'),
      SubCategoryItem(name: 'Electric Cars', imagePlaceholder: 'Electric car'),
      SubCategoryItem(name: 'Drones', imagePlaceholder: 'Drone'),
    ],
  ),
  CategorySection(
    title: 'Sports & Entertainment',
    subItems: [
      SubCategoryItem(name: 'Tractors', imagePlaceholder: 'Tractor'),
      SubCategoryItem(name: 'Smart Watches', imagePlaceholder: 'Smart watch'),
      SubCategoryItem(
          name: 'Vending Machines', imagePlaceholder: 'Vending machine'),
    ],
  ),
];

List<ProductInspirationCard> productInspirationCard = [
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
];




class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
       
      ),
      body: LayoutBuilder(builder: (BuildContext contex, BoxConstraints sizes) {
        if (sizes.maxWidth > 600) {
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8,
                childAspectRatio: 1.0),
            itemCount: categorySection.length,
            itemBuilder: (context, index) {
              return _body(index);
            },
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: categorySection.length,
            itemBuilder: (context, index) {
              return _body(index);
            },
          );
        }
      }),
    );
  }

  Widget _body(int index) {
    return SizedBox(
        child: Wrap(children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'For you',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      categorySection[index],
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Get product inspiration',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
     productInspirationCard[index]
    ]));
  }
}

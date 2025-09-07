import 'package:dalell/oop/statedemo.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}


class _CategoriesPageState extends State<CategoriesPage> {
  String searchCategoryName = "";
  String searchPrice = "";

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

  @override
  Widget build(BuildContext context) {
    // Filter lists based on search values
    List<CategorySection> filteredCategorySection = categorySection
        .where((cat) => cat.title.toLowerCase().contains(searchCategoryName.toLowerCase()))
        .toList();

    List<ProductInspirationCard> filteredProductInspirationCard = productInspirationCard
        .where((prod) => prod.price != null && prod.price!.contains(searchPrice))
        .toList();

    List<Widget> gridItems = [
      const Text(
        'For you',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      ...filteredCategorySection,
      const Text(
        'Product Inspirations',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      ...filteredProductInspirationCard,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter fields
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Search Category Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchCategoryName = value;
                });
              },
            ),
            // const SizedBox(height: 12),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     labelText: 'Search Product Price',
            //     border: OutlineInputBorder(),
            //   ),
            //   onChanged: (value) {
            //     setState(() {
            //       searchPrice = value;
            //     });
            //   },
            // ),
            const SizedBox(height: 16),
            // Responsive grid/list
            Expanded(
              child: LayoutBuilder(
                builder: (context, sizes) {
                  if (sizes.maxWidth > 600) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: gridItems.length,
                      itemBuilder: (context, index) {
                        return gridItems[index];
                      },
                    );
                  } else {
                    return ListView(
                      children: gridItems,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
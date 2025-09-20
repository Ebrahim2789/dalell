import 'package:dalell/config/theme/inputdecoration.dart';
import 'package:dalell/oop/statedemo.dart';
import 'package:dalell/product/controller/product_controller.dart';
import 'package:dalell/product/models/product.dart';
import 'package:dalell/product/repositories/brand_repository.dart';
import 'package:dalell/product/repositories/category_repository.dart';

import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final ProductController controller = ProductController();

  final categorRepo = CategoryRepository();
  final brandRepo = BrandRepository();
  List<Product> products = [];
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    final data = await controller.getAllProducts();
    final cat = await categorRepo.getAllCategory();

    if (data.isEmpty) {
      await controller.insertProduct(StaticData.products.first);
    }

    setState(() {
      products = data;
      categories = cat;
    });
  }

  String searchCategoryName = "";
  String searchPrice = "";

  @override
  Widget build(BuildContext context) {
    List<CategorySection> categorySection = [];
    List<ProductInspirationCard> productInspirationCard = [];

    // for (var cat in categories) {
    //   categorySection.add(CategorySection(title: cat.name, subItems: [
    //      SubCategoryItem(
    //           name: products.map((v)=>v.name).first,
    //           imagePlaceholder: products[1].media.map((va) => va.url).first,
    //         ),
    //   ]));
    // }

    for (var p in products) {
      categorySection.add(
        CategorySection(
          title: p.category!.name,
          subItems: [
            SubCategoryItem(
              name: p.name,
              imagePlaceholder: p.media.map((va) => va.url).first,
            ),
            SubCategoryItem(
              name: p.name,
              imagePlaceholder: p.media.map((va) => va.url).first,
            ),
            SubCategoryItem(
              name: p.name,
              imagePlaceholder: p.media.map((va) => va.url).last,
            ),
          ],
        ),
      );

      productInspirationCard.add(
        ProductInspirationCard(
          imagePlaceholder: p.media.map((va) => va.url).first,
          price: 'ETB ${p.price}',
          minOrder: 'Min. order: 1 set',
        ),
      );
    }
    // Filter lists based on search values
    List<CategorySection> filteredCategorySection = categorySection
        .where((cat) =>
            cat.title.toLowerCase().contains(searchCategoryName.toLowerCase()))
        .toList();

    List<ProductInspirationCard> filteredProductInspirationCard =
        productInspirationCard
            .where((prod) =>
                prod.price != null && prod.price!.contains(searchPrice))
            .toList();

    List<Widget> gridItems = [

 
       
           Padding(
        padding: const EdgeInsets.all(8.0),
        
       child:   const Text(
          'For you',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
           ),
      
      ...filteredCategorySection,
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: const Text(
          'Product Inspirations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      ...filteredProductInspirationCard,
    
      
      
      ];

    return Scaffold(
      appBar: AppBar(
        title: // Filter fields
            TextFormField(
          decoration: const InputDecoration(
            labelText: 'Search Category Name',
            border: OutlineInputBorder(),
            focusedBorder: focusedOutlineInputBorder,
            enabledBorder: outlineInputBorder,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              searchCategoryName = value;
            });
          },
        ),
        actions: [],
      ),
      body: 
      
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Responsive grid/list
            Expanded(
              child: LayoutBuilder(
                builder: (context, sizes) {
                  if (sizes.maxWidth > 600) {
                    return
                    
                    GridView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                             itemCount: gridItems.length,
                      itemBuilder: (context, index) =>
                         gridItems[index]
                    
                      
                    );
                  } else {
                    return 
                    
                    
                    ListView(
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

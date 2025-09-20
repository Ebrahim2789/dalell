// product_repository.dart

import 'package:dalell/app/star.dart';
import 'package:dalell/product/repositories/brand_repository.dart';
import 'package:dalell/product/repositories/category_repository.dart';
import 'package:dalell/product/repositories/product_media_repository.dart';
import 'package:dalell/product/view/product_page.dart';
import 'package:dalell/routes/routes.dart';
import 'package:dalell/config/theme/inputdecoration.dart';
import 'package:flutter/material.dart';
import '../controller/product_controller.dart';
import '../models/product.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  ProductListViewState createState() => ProductListViewState();
}

class ProductListViewState extends State<ProductListView> {
  final ProductController controller = ProductController();
  final mediaRepo = ProductMediaRepository();
  final categorRepo = CategoryRepository();
  final brandRepo = BrandRepository();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    final data = await controller.getAllProducts();

    if (data.isEmpty) {
      await controller.insertProduct(StaticData.products.first);
    }

    setState(() {
      products = data;
    });
  }

  void _deleteProduct(String id) async {
    await controller.deleteProduct(id);
    _loadProducts();
  }

  void _openForm({Product? product}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductPage(product: product)),
    );
    if (result == true) _loadProducts();
  }

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
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          centerTitle: true,
          elevation: 4.0, // Shadow for AppBar

          actions: [
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black87),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteGenerator.productEditorPage);
              },
            ),
          ],
        ),
        body:
            LayoutBuilder(builder: (BuildContext contex, BoxConstraints sizes) {
          if (sizes.maxWidth > 600) {
            return GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return SizedBox(
                  child: padding(context, product, index, sizes),
                );
              },
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return padding(context, product, index, sizes);
              },
            );
          }
        }));
  }

  Widget padding(
      BuildContext context, Product product, int index, BoxConstraints sizes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () => _openForm(product: product),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: [
              // Product Image (using first media URL)
              // Container(
              //   height: sizes.maxWidth> 500?300:200,
              //   // width: 200,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage(product.media[index].url),
              //       fit: BoxFit.cover,
              //     ),

              //     borderRadius:
              //         const BorderRadius.vertical(top: Radius.circular(16.0)),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withAlpha(100),
              //         blurRadius: 10.0,
              //         offset: const Offset(0, 4),
              //       ),
              //     ],
              //   ),

              // ),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: Image.asset(
                    product.media[index].url,
                    height: 300,
                  ),
                  title: Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: const Text('Promo details here...'),
                  trailing: IconButton(
                      onPressed: () {}, icon: Icon(Icons.shopping_cart)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (sizes.maxWidth > 700) const SizedBox(height: 8.0),
                    Expanded(
                        child: Column(children: [
                      Text(
                        'Descrption:   ${product.description}, ',
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Brand:   ${product.brand!.name}, ',
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (sizes.maxWidth > 700) const SizedBox(width: 16.0),
                      Text(
                        'Category: ${product.category!.name}',
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ])),
                    if (sizes.maxWidth > 700) const SizedBox(height: 12.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specifications:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        ...product.attributes.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(left: 1.0, top: 1.0),
                            child: Text(
                              '• ${entry.name}: ${entry.options.map((v) => v.value)}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // const SizedBox(height: 12.0),
                        // Text(
                        //   'Options:',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyMedium
                        //       ?.copyWith(fontWeight: FontWeight.bold),
                        // ),
                        // Wrap(
                        //   spacing: 8.0,
                        //   children: product.options
                        //       .map(
                        //         (option) => Chip(
                        //           label: Text(option.value),
                        //           backgroundColor: Colors.blue.shade100,
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(20.0),
                        //             side: BorderSide(
                        //                 color: Colors.blue.shade300),
                        //           ),
                        //         ),
                        //       )
                        //       .toList(),
                        // ),
                        // const SizedBox(height: 12.0),
                        // Text(
                        //   'Media:',
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyMedium
                        //       ?.copyWith(fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(
                        //   height: 100.0,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: product.media.length,
                        //     itemBuilder: (context, mediaIndex) {
                        //       return Padding(
                        //         padding: const EdgeInsets.only(right: 8.0),
                        //         child: Container(
                        //           width: 100.0,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8.0),
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 color: Colors.grey.withAlpha(128),
                        //                 blurRadius: 5.0,
                        //                 offset: const Offset(0, 2),
                        //               ),
                        //             ],

                        //             image: DecorationImage(
                        //               image: AssetImage(
                        //                   product.media[index].url),
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),

                        StarRating(
                          color: Colors.yellow,
                          value: 5,
                        ),
                        if (sizes.maxWidth > 700) const SizedBox(height: 12.0),
                      ],
                    )
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

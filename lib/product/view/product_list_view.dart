// product_repository.dart

import 'package:dalell/product/repositories/product_media_repository.dart';
import 'package:flutter/material.dart';
import '../controller/product_controller.dart';
import '../models/product.dart';
import 'product_form_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ProductController controller = ProductController();
        final mediaRepo = ProductMediaRepository();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
      //  await controller.insertProduct(StaticData.products.first);
    final data = await controller.getAllProducts();

    

    if (data.isEmpty) {
      await controller.insertProduct(StaticData.products.first);
    }

    //  List<Product>  pro= List.from(products);
    // pro.toList(growable: true);
    //   List<ProductAttribute> alist =
    //       await attributRepo.getAProductAteribute(p.id!);
    //   for (var a in alist) {
    //     print("   attt is : ${a.name} (${a.productId})");

    //     List<ProductOption> olist =
    //         await optionRepo.getProductOptionByProduct(a.id!);

        // for (var o in olist) {
        //   a.options.add(o);
          
        // }
        // p.attributes.add(a);

      // }
      

    // print(data);
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
      MaterialPageRoute(builder: (_) => ProductFormView(product: product)),
    );
    if (result == true) _loadProducts();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Products")),
  //     body: ListView.builder(
  //       itemCount: products.length,
  //       itemBuilder: (context, index) {
  //         final p = products[index];
  //         return ListTile(
  //           title: Text(p.name),
  //           subtitle: Text("${p.description} - \$${p.price}"),
  //           trailing: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               IconButton(
  //                 icon: Icon(Icons.edit, color: Colors.blue),
  //                 onPressed: () => _openForm(product: p),
  //               ),
  //               IconButton(
  //                 icon: Icon(Icons.delete, color: Colors.red),
  //                 onPressed: () => _deleteProduct(p.id),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       child: Icon(Icons.add),
  //       onPressed: () => _openForm(),
  //     ),
  //   );
  // }

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
                      // image: DecorationImage(
                      //   image: AssetImage(product.media[index].url),
                      //   fit: BoxFit.cover,
                      // ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/image2.jpg'),
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
                              product.brandId.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 16.0),
                            Text(
                              'Category: ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              product.categoryId.toString(),
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
                        ...product.attributes.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Text('• ${entry.name}: ${entry.options}'),
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
                                  label: Text(option.value),
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
                                      image: AssetImage(
                                          'assets/images/image2.jpg'),
                                      fit: BoxFit.cover,
                                    ),

                                    // image: DecorationImage(
                                    //     image: AssetImage(product.media[index].url),
                                    //   fit: BoxFit.cover,
                                    // ),
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






// class ProductListView extends StatefulWidget {
//   @override
//   _ProductListViewState createState() => _ProductListViewState();
// }

// class _ProductListViewState extends State<ProductListView> {
//   final ProductController controller = ProductController();
//   List<Product> products = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadProducts();
//   }

//   void _loadProducts() async {
//     final data = await controller.getAllProducts();
//     setState(() {
//       products = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Products")),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final p = products[index];
//           return ListTile(
//             title: Text(p.name),
//             subtitle: Text("${p.description} - \$${p.price}"),
//           );
//         },
//       ),
//     );
//   }
// }


// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ProductListView(),
//   ));
// }
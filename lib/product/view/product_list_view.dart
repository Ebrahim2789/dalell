// product_repository.dart

import 'package:dalell/app/star.dart';
import 'package:dalell/product/repositories/brand_repository.dart';
import 'package:dalell/product/repositories/category_repository.dart';
import 'package:dalell/product/repositories/product_media_repository.dart';
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
    //  await controller.insertProduct(StaticData.products.first);
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
            //   height: sizes.maxWidth> 200.0?300:300,
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
                  'assets/images/image2.jpg',
                  height: 200,
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
                            '• ${entry.name}: ${entry.options[index].value}',
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


class ProductPage extends StatefulWidget {
  final Product? product;
  const ProductPage({super.key, this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;
  String selectedSize = 'M';
  String selectedColor = 'Red';

  final List<String> sizes = ['S', 'M', 'L'];
  final List<String> colors = ['Red', 'Blue', 'Green'];

  void addToCart() {
    showHalfScreenConfirmation(context: context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to cart'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget buildOptionSelector(String title, List<String> options,
      String selected, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: options.map((option) {
            final isSelected = selected == option;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) => onSelect(option),
              selectedColor: Colors.blueAccent,
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.orange,
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  widget.product?.media.first.url ?? 'assets/images/image2.jpg',

                  fit: BoxFit.cover,

                  //  Icon(Icons.image, size: 100)im
                ),
              ),

              const SizedBox(height: 16),

              // Product Name & Price
              Text(widget.product!.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              const Divider(),

              Row(
                spacing: 0.2,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Prices',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(widget.product!.price.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                  ),
                ],
              ),

              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: Text(
                    "${widget.product!.description} ",
                    style: TextStyle(fontSize: 16),
                  ))
                ],
              ),

              Text(
                'Attributes:',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              ...widget.product!.attributes.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text('• ${entry.name}: ${entry.options[1].value}'),
                ),
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
                  itemCount: widget.product!.media.length,
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
                                widget.product!.media[mediaIndex].url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Size Selector
              buildOptionSelector("Select Size", sizes, selectedSize, (value) {
                setState(() => selectedSize = value);
              }),

              const SizedBox(height: 16),
              // Color Selector
              buildOptionSelector("Select Color", colors, selectedColor,
                  (value) {
                setState(() => selectedColor = value);
              }),

              const SizedBox(height: 16),

              // Quantity Selector
              Row(
                children: [
                  const Text("Quantity",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed:
                        quantity > 1 ? () => setState(() => quantity--) : null,
                  ),
                  Text(quantity.toString(),
                      style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => setState(() => quantity++),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Min. Order: 1 piece',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),

              Row(children: [
                Text(
                  'Specifications',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' Camera: 4K HD'),
                      Text(' Flight Time: 25 minutes'),
                    ],
                  ),
                )
              ]),

              const Divider(),
              const Row(
                children: [
                  Text(
                    'Supplier Info',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  Supplier: Tech Innovations Ltd.'),
                        Text('  Location: Shenzhen, China'),
                        Text('  Response Rate: 95%'),
                        Text('  Trade Assurance: Available'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text('Contact Supplier'),
                ),
              ),

              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: addToCart,
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text("Add to Cart"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}

Future<bool?> showHalfScreenConfirmation({
  required BuildContext context,
  String title = "Confirmation",
  String content = "Are you sure you want to continue?",
  String confirmText = "Yes",
  String cancelText = "Cancel",
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.5, // 👈 Half screen height
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Top Row with title + Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded,
                          color: Colors.red, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 24),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Content text
              Expanded(
                child: Center(
                  child: Text(
                    content,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(cancelText),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(confirmText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
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
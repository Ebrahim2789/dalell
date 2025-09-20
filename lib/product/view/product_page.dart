// product_repository.dart

import 'package:dalell/config/constant.dart';
import 'package:dalell/config/theme/inputdecoration.dart';
import 'package:dalell/container/container.dart';
import 'package:dalell/order/controller/address_controller.dart';
import 'package:dalell/order/controller/orderController.dart';
import 'package:dalell/order/models/address.dart';
import 'package:dalell/order/models/order.dart';
import 'package:dalell/order/views/order_form.dart';
import 'package:dalell/product/models/product.dart';
import 'package:dalell/product/view/product_list_view.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Product? product;
  const ProductPage({super.key, this.product});

  @override
  State<ProductPage> createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  final AddressController addressController = AddressController();
  final OrderController orderController=OrderController();
  String? selectedAddressId;
  List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _loadAddresses() async {
    final data = await addressController.getAllAddresses();
    setState(() => addresses = data);
  }

  int quantity = 1;
  String selectedSize = 'M';
  String selectedColor = 'Red';

  final List<String> sizes = ['S', 'M', 'L'];

  // final List<String> colors = ['Red', 'Blue', 'Green'];

  Future<void> addToCart(Order order) async {
  showHalfScreenConfirmation(context: context, order: order);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to cart'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  }

 void  _saveOrder(Order order) async {
 
    if (order.toMap().isNotEmpty && selectedAddressId != null) {

      
  var result=    await orderController.insertOrder(order);
  print(result);
    
      Navigator.pop(context);
    }
  }

  Widget buildOptionSelector(String title, List<String> options,
      String selected, Function(String) onSelect) {
    List<String> newOption = options.toSet().toList();



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: newOption.map((newOption) {
            final isSelected = selected == newOption;
            return ChoiceChip(
              label: Text(newOption),
              selected: isSelected,
              onSelected: (_) => onSelect(newOption),
              selectedColor: Colors.blueAccent,
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var order = Order(
      productId: widget.product!.id,
      quantity: quantity,
      total: widget.product!.price * quantity,
      status: "Pending",
      createdAt: DateTime.now().toIso8601String(),
      addressId: '', // use selected address
    );
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
              containerCard(
                Row(
                  spacing: 0.2,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Prices',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(widget.product!.price.toString(),
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                    Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Text(
                      "${widget.product!.description} ",
                      style: TextStyle(fontSize: 16),
                    ))
                  ],
                ),
              ),

              const SizedBox(height: 12.0),
              containerCard(
                Column(
                  children: [
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
                        child:

                            // Size Selector

                            buildOptionSelector(
                                "Select ${entry.name}",
                                entry.options
                                    .map((v) => (v.value))
                                    .toSet()
                                    .toList(),
                                selectedSize, (value) {
                          setState(() => selectedSize = value);
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // const SizedBox(height: 16),
                    // // Color Selector
                    // buildOptionSelector("Select Color", colors, selectedColor,
                    //     (value) {
                    //   setState(() => selectedColor = value);
                    // }),

                    // Quantity Selector
                    Row(
                      children: [
                        const Text("Quantity",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: quantity > 1
                              ? () => setState(() => quantity--)
                              : null,
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

                    const Divider(),
                    const Row(
                      children: [
                        Text(
                          'Supplier Info',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
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
                        onPressed: () {
                          addToCart(order);
                        },

                        // loadOrder(widget.product!),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showHalfScreenConfirmation({
    required BuildContext context,
    String title = "Confirmation",
    String content = "Are you sure you want to continue?",
    String confirmText = "Yes",
    String cancelText = "Cancel",
    required Order order,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      // backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7, // 👈 Half screen height
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
                        //       const SizedBox(height: 12),
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
                      child: Column(
                    children: [
                      Text(
                        content,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      buildRow("Product Name", widget.product!.name),
                      buildRow("Total price", order.total.toString()),
                      buildRow("Daily income", order.productId.toString()),
                      buildRow("Contract period", order.createdAt),
                      buildRow("Total profit", "98 Br"),
                      DropdownButtonFormField<String>(
                        initialValue: selectedAddressId,
                        items: addresses.map((a) {
                          return DropdownMenuItem(
                            value: a.city,
                            child: Text("${a.customerName} - ${a.city}"),
                          );
                        }).toList(),
                        onChanged: (v) => setState(() {selectedAddressId = v;
                        order.addressId=selectedAddressId;
                        }),
                        decoration:
                            InputDecoration(labelText: "Select Address"),
                        validator: (v) =>
                            v == null ? "Please select an address" : null,
                      ),
                      const SizedBox(height: 12),
                      const Text("Purchase limit 1 per person",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  )),
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
                        onPressed: (){
                             _saveOrder(order);
                             Navigator.pop(context, true);
                        } ,
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
}

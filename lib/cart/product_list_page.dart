import 'package:dalell/cart/trending_items.dart';
import 'package:dalell/product/models/product.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: Expanded(
        child: FutureBuilder<List<Product>>(
          future: TrendingItems().getProductList(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.none) {
              return const Center(
                child: Text('An error occurred!'),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.error != null) {
                  // ...
                  // Do error handling stuff
                  return const Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  List<Product> data = snapshot.data!;

                  return GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 4.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      var product = data[index];
                      print(product.name);
                      return GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Hero(
                                    transitionOnUserGestures: true,
                                    tag: product.id!,
                                    child: Image(
                                      image: AssetImage(
                                        product.media[index].url!,
                                      ),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 180,
                                    ),

                                    // CachedNetworkImage(
                                    //   imageUrl: widget.product.image!,
                                    //   fit: BoxFit.cover,
                                    //   width: double.infinity,
                                    //   height: 180,
                                    //   placeholder: (context, url) =>
                                    //       const Center(child: CircularProgressIndicator()),
                                    //   errorWidget: (context, url, error) => const Icon(Icons.error),
                                    // ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(product.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Row(
                                  children: [
                                    Text("\$${product.price.toString()}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.shopping_cart),
                                        color: Colors.black,
                                        iconSize: 25,
                                        onPressed: () {
                                          // .addToCart(product, 1, "");
                                        }),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }

            return const Text("");
          },
        ),
      ),

      // FutureBuilder<List<Product>>(
      //   future: TrendingItems().getProductList(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     }
      //     final products = snapshot.data ?? [];
      //     if (products.isEmpty) {
      //       return const Center(child: Text('No products found.'));
      //     }
      //     return ListView.builder(
      //       itemCount: products.length,
      //       itemBuilder: (context, index) {
      //         final product = products[index];
      //         return Card(
      //           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      //           child: ListTile(
      //             leading: Image.asset(
      //               product.image!,
      //               width: 60,
      //               height: 60,
      //               fit: BoxFit.cover,
      //             ),
      //             name: Text(product.name!),
      //             subname: Text(product.description!),
      //             trailing: Text(
      //               'ETB ${product.price!.toStringAsFixed(2)}',
      //               style: const TextStyle(
      //                   fontWeight: FontWeight.bold, color: Colors.orange),
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}

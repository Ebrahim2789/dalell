import 'package:dalell/cart/trending_items.dart';
import 'package:dalell/product/models/product.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
  int notificationCount = 0; // Replace with your dynamic value

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // Handle cart tap
                },
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: 
        FutureBuilder<List<Product>>(
          future: TrendingItems().getProductList(),
          builder: (BuildContext context, snapshot, ) {
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
                    var screenSize = MediaQuery.of(context).size;

                  return GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount (
                          crossAxisCount: screenSize.width>600?4:2,
                       
                            childAspectRatio: 3 / 4.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      var product = data[index];
               
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
                            child: Wrap(
                              
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Hero(
                                    transitionOnUserGestures: true,
                                    tag: product.id!,
                                    child: Image(
                                      image: AssetImage(
                                        product.media.first.url!,
                                        
                               
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
                                Text(product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),

                                  Text(product.description.trimLeft(),  style:
                                        Theme.of(context).textTheme.bodyMedium  ),
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
                                          notificationCount++;
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
      

    
    );
  }
}

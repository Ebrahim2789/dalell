import 'package:dalell/product/models/media.dart';
import 'package:dalell/product/models/product.dart';

class TrendingItems {
  Future<List<Product>> getProductList() async {
    return [
      Product(
        id: 1,
        name: 'Wireless Headphones',
        price: 129.99,
        description:
            "High-quality wireless headphones with noise cancellation.",
        category: 'Electronics',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
      Product(
        id: 2,
        name: 'Running Shoes',
        price: 59.49,
        description: "Lightweight running shoes for everyday training.",
        category: 'Sportswear',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
      Product(
        id: 3,
        name: 'Smart Watch',
        price: 199.00,
        description: "Smart watch with heart rate monitor and GPS.",
        category: 'Electronics',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
      Product(
        id: 4,
        name: 'Coffee Maker',
        price: 89.99,
        description: "Automatic coffee maker with programmable timer.",
        category: 'Home Appliances',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
      Product(
        id: 5,
        name: 'Leather Wallet',
        price: 25.75,
        description: "Genuine leather wallet with multiple compartments.",
        category: 'Accessories',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
      Product(
        id: 6,
        name: 'Bluetooth Speaker',
        price: 45.00,
        description: "Portable Bluetooth speaker with deep bass.",
        category: 'Electronics',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
      Product(
        id: 7,
        name: 'Yoga Mat',
        price: 19.99,
        description: "Eco-friendly yoga mat for all types of exercises.",
        category: 'Sportswear',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
      Product(
          id: 8,
          name: 'Sunglasses',
          price: 35.50,
          description: "Stylish sunglasses with UV protection.",
          category: 'Accessories',
          media: [
            Media(
                id: 3,
                url: 'assets/images/image2.jpg',
                type: 'image',
                productid: 1),
          ]),
      Product(
        id: 9,
        name: 'Backpack',
        price: 54.99,
        description: "Durable backpack suitable for travel and school.",
        category: 'Bags',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
      Product(
        id: 10,
        name: 'Desk Lamp',
        price: 22.99,
        description: "LED desk lamp with adjustable brightness.",
        category: 'Home Appliances',
        media: [
          Media(
              id: 3,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
          Media(
              id: 4,
              url: 'assets/images/image2.jpg',
              type: 'image',
              productid: 1),
        ],
      ),
    ];
  }
}

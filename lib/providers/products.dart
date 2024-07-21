import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import '../models/product.dart';

class Products with ChangeNotifier {
  final List<Product> _list = [
    Product(
      id: '1',
      title: 'Laptop',
      description: 'High performance laptop with 16GB RAM and 512GB SSD.',
      imageUrl:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
      price: 1200.00,
    ),
    Product(
      id: '2',
      title: 'Smartphone',
      description: 'Latest model smartphone with 5G connectivity.',
      imageUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60',
      price: 800.00,
    ),
    Product(
      id: '3',
      title: 'Wireless Headphones',
      description:
          'Noise-cancelling wireless headphones with long battery life.',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1683531060718-4dd0a8f2a692?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YWlycG9kfGVufDB8fDB8fHww',
      price: 150.00,
    ),
  ];

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return _list.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _list.firstWhere((element) => element.id == id);
  }

  void addProduct(Product product)async {
    final url = Uri.parse(
        "https://shopping-app-8d541-default-rtdb.firebaseio.com/products.json");
   await http.post(
      url,
      body: jsonEncode(
        {
          "title": product.title,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "price": product.price,
          "isFavorite": product.isFavorite,
        },
      ),
    );
    _list.add(
      Product(
        id: UniqueKey().toString(),
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      ),
    );
    notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    int index = _list.indexWhere((element) => element.id == updatedProduct.id);

    if (index >= 0) {
      _list[index] = updatedProduct;
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    _list.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

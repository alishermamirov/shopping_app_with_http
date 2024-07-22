import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/cart_item.dart';
import '../models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  Future<void> addToOrders(double totalPrice, List<CartItem> products) async {
    final url = Uri.parse(
        "https://shopping-app-8d541-default-rtdb.firebaseio.com/orders.json");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "totalprice": totalPrice,
            "date": DateTime.now().toIso8601String(),
            "products": products,
          },
        ),
      );

      final name = (jsonDecode(response.body) as Map<String, dynamic>)["name"];
      _items.insert(
        0,
        Order(
          id: name,
          totalprice: totalPrice,
          date: DateTime.now(),
          products: products,
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}

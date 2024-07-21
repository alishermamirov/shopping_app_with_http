import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void addToOrders(double totalPrice, List<CartItem> products) {
    _items.insert(
      0,
      Order(
        id: UniqueKey().toString(),
        totalprice: totalPrice,
        date: DateTime.now(),
        products: products,
      ),
    );
    notifyListeners();
  }
}

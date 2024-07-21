// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';
import 'product_grid_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
    required this.showOnlyFavorites,
  }) : super(key: key);

  final bool showOnlyFavorites;

  @override
  Widget build(BuildContext context) {
    
    final productData = Provider.of<Products>(context);
    final products =
        showOnlyFavorites ? productData.favorites : productData.list;
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider<Product>.value(
          value: products[index],
          child: const ProductGridItem(),
        );
      },
    );
  }
}

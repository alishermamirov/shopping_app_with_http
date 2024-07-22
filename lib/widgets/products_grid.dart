// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';
import 'product_grid_item.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({
    Key? key,
    required this.showOnlyFavorites,
  }) : super(key: key);

  final bool showOnlyFavorites;

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  var _init = true;
  var _isLoading = false;
  // @override
  // void initState() {
  //   // Provider.of<Products>(context,listen: false).getProductFromFirebase();
  //   Future.delayed(Duration.zero).then(
  //     (value) {
  //       Provider.of<Products>(context, listen: false).getProductFromFirebase();
  //     },
  //   );
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .getProductFromFirebase()
          .then(
        (value) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
    setState(() {
      _init = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =
        widget.showOnlyFavorites ? productData.favorites : productData.list;
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return products.isEmpty
          ? Center(
              child: Text("Mahsulotlar mavjud emas"),
            )
          : GridView.builder(
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
}

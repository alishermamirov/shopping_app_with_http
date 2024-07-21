import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/orders.dart';
import 'screens/cart_screen.dart';
import 'providers/cart.dart';
import 'providers/products.dart';
import 'screens/edit_product_screen.dart';
import 'screens/home_screen.dart';
import 'screens/manage_product_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_details_screen.dart';
import 'theme/shopping_app_theme.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData theme = ShoppingAppTheme.theme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (context) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
          ManageProductScreen.routeName: (context) => ManageProductScreen(),
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
        },
        initialRoute: HomeScreen.routeName,
        home: HomeScreen(),
      ),
    );
  }
}

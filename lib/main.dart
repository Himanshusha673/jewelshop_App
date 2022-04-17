import 'package:flutter/material.dart';
import 'package:jewelshop/screens/product_details_Screens.dart';
import 'package:jewelshop/screens/product_owerview.dart';
import './Provider/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlue,
        ),
        home: ProductOverview(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
        },
      ),
    );
  }
}

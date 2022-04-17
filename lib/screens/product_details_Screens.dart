import 'package:flutter/material.dart';
import 'package:jewelshop/Provider/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  //final String title;
  static const routeName = "/product-details";

  //ProductDetailsScreen(this.title);
  @override
  Widget build(BuildContext context) {
    // Here we are passing arguement id via routing withour any constructor used
    final productId =
        ModalRoute.of(context)!.settings.arguments as String; //is the id
    //loadedproduct is an instatnce which points to current product
    final loadedproduct = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(loadedproduct.title)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jewelshop/Provider/products_provider.dart';
import 'package:jewelshop/screens/product_details_Screens.dart';
import '../Provider/product.dart';
import 'product_items.dart';
import 'package:provider/provider.dart';
import '../Provider/product.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productdata = Provider.of<ProductProvider>(context);
    final products = productdata.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (c) => products[i],
        child: ProductItems(
            //products[i].id, products[i].imageUrl, products[i].title,
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/product_grid.dart';
import '../widgets/product_items.dart';

class ProductOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Jewelshop"),
      ),
      body: ProductGrid(),
    );
  }
}

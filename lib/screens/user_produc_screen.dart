import 'package:flutter/material.dart';
import 'package:jewelshop/screens/edit_screen.dart';
import 'package:jewelshop/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../Provider/products_provider.dart';
import '../widgets/user_product_screen_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routename = '/User_product_screen';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    return Scaffold(
      drawer: Mydrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditScreen.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserproductItems(productsData.items[i].imageUrl,
                  productsData.items[i].title, productsData.items[i].id),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

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
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(title: Text(loadedproduct.title)),
        body: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    loadedproduct.imageUrl,
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "\₹ ${loadedproduct.price}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                " ${loadedproduct.description}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}

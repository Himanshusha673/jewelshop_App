import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/product.dart';
import '../screens/product_details_Screens.dart';

class ProductItems extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItems(this.id, this.imageUrl, this.title);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: product.id);
          },
        ),
        footer: GridTileBar(
            leading: IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                product.toggleFavouritestatus();
              },
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            ),
            backgroundColor: Colors.black45,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}

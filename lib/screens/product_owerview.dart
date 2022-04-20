import 'package:flutter/material.dart';
import 'package:jewelshop/screens/cart_screen.dart';
import 'package:jewelshop/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';
import '../widgets/product_items.dart';
import '../Provider/cart.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverview extends StatefulWidget {
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var showFavouritesOnly = false;
  @override
  Widget build(BuildContext context) {
    // we dont want to chnage the update but only we need to access data

    //final productContainer = Provider.of<ProductProvider>(context,listen: false);
    //--- we dont use this one
    // because we work on appside view of provider so their s best approch is to use statefull widget with
    //setstate so that if we move on another screen then change not occurs by using setstate chanege
    // where only affect single screen is best approch to managing only thios productoverview widget
    //and its child productgrid wigdet
    return Scaffold(
      appBar:
          AppBar(centerTitle: true, title: Text("Jewelshop"), actions: <Widget>[
        Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            child: Container(child: ch),
            value: cart.itemCount.toString(),
          ),
          child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routname);
            },
          ),
        ),
        PopupMenuButton(
          onSelected: (FilterOptions selectedvalue) {
            setState(() {
              if (selectedvalue == FilterOptions.Favourites) {
                // we don't use this methods of productprovider class as mention above
                // productContainer.showFavourite();
                showFavouritesOnly = true;
              } else {
                // productContainer.showAll();
                showFavouritesOnly = false;
              }
            });
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text("Only Favourites"),
              value: FilterOptions.Favourites,
            ),
            PopupMenuItem(
              child: Text(" Show All"),
              value: FilterOptions.All,
            ),
          ],
        ),
      ]),
      body: ProductGrid(showFavouritesOnly),
    );
  }
}

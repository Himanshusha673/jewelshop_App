import 'package:flutter/material.dart';
import 'package:jewelshop/Provider/cart.dart';
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
    //this is the listener called by notifylistner() method present in togglefavuorite
    //method in product class where we use channgenotifier mixin and if we pass listen =false
    //in productofcontext then it cant listen anything and change wont work but by default it is true
    final product = Provider.of<Product>(context, listen: false);
    // there i am using the product field but i cant update changes because listen is false
    //we can now use another approch to listen by cosumer method by wrapping it in a widget that is to be update
    //provider of conetxt used foe just here for extracting datat from our change notify which is in our product
    // class in a variable product and if  we not  used listen false here, then it is used for also listen the
    // changes is to update
    final cart = Provider.of<Cart>(context, listen: false);
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
            leading: Consumer<Product>(
              builder: (context, provider, _) => IconButton(
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  product.toggleFavouritestatus();
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                cart.additems(
                    product.id.toString(), product.price, product.title);
                Scaffold.of(context)
                    .hideCurrentSnackBar(); //this will  remove existing snackbar and add new one
                //changes in this scaffold shows the nearest scaffold of this one
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Added to the Cart!",
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItems(product.id.toString());
                      },
                    ),
                  ),
                );
              },
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

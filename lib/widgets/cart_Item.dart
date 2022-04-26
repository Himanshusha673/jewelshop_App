import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final double price;
  final int quantity;
  CartItem({
    required this.productId,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        //we dont want to listen here because w eonly
        // need to dispatch the data and changess update by the listner of cartscreen clas
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      confirmDismiss: (direction) {
        //here showdiialog return a future and confirmdialog also return future
        // but it needs to be return boolean type
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure ?'),
            content: Text(
              'Do You want to remove this Item',
              style: TextStyle(fontSize: 14),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text('No')),
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 55,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: ListTile(
              leading: CircleAvatar(child: FittedBox(child: Text("\₹$price"))),
              title: Text(title),
              subtitle: Text(
                'Total: \₹${(price * quantity)}',
              ),
              trailing: Text('$quantity x'),
            ),
          ),
        ),
      ),
    );
  }
}

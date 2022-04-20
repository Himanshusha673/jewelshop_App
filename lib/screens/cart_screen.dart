import 'package:flutter/material.dart';
import 'package:jewelshop/Provider/cart.dart'
    show Cart; // this is used to remove name clash
import 'package:jewelshop/Provider/orders.dart';
//which is cartitem one which presnent in cartprovider another present inside widget
import 'package:jewelshop/widgets/cart_Item.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routname = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your Cart Items"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Spacer(),
                    Chip(
                      label: Text('${cart.totalAmount} \₹ '),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrders(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (Context, i) => CartItem(
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title,
              ),
              itemCount: cart.items.length,
            ),
          ),
        ],
      ),
    );
  }
}

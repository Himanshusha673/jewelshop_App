import 'package:flutter/material.dart';
import 'package:jewelshop/Provider/orders.dart' show Orders; // by this we
import 'package:jewelshop/widgets/drawer.dart';
//   can only access the order class not orderitem class of order.dart otf provider
import 'package:jewelshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
        centerTitle: true,
      ),
      drawer: Mydrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}

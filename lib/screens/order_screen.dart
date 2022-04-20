import 'package:flutter/material.dart';
import 'package:jewelshop/Provider/orders.dart' show Orders; // by this we
//   can only access the order class not orderitem class of order.dart otf provider
import 'package:jewelshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);

    return ListView.builder(
      itemCount: orderData.orders.length,
      itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
    );
  }
}

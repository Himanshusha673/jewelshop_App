import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jewelshop/Provider/orders.dart' as ord;
// for removing name clash in
// wdget and provider  same name of order.item ut we need onlt order itewm o0f order of provider

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;
  OrderItem(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${order.amount}'),
            subtitle:
                Text(DateFormat("dd mm yyyy hh:mm").format(order.dateTime)),
            trailing:
                IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
          )
        ],
      ),
    );
  }
}

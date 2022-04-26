import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jewelshop/Provider/orders.dart' as ord;
// for removing name clash in
// wdget and provider  same name of order.item ut we need onlt order itewm o0f order of provider

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${widget.order.amount}'),
            subtitle: Text(
                DateFormat("dd/mm/yyyy-hh:mm").format(widget.order.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _isExpand = !_isExpand;
                  });
                },
                icon: Icon(_isExpand ? Icons.expand_less : Icons.expand_more)),
          ),
          if (_isExpand)
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: min(widget.order.products.length * 20.0 + 10, 100),
                child: ListView(
                  children: widget.order.products
                      .map(
                        (prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              prod.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${prod.quantity} x \$ ${prod.price}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                )),
        ],
      ),
    );
  }
}

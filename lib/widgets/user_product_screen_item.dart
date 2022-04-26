import 'package:flutter/material.dart';
import 'package:jewelshop/Provider/products_provider.dart';
import 'package:provider/provider.dart';

class UserproductItems extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  UserproductItems(this.imageUrl, this.title, this.id);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
                onPressed: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .deleteItem(id);
                },
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor)
          ],
        ),
      ),
    );
  }
}

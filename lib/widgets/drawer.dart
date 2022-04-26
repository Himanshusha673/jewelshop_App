import 'package:flutter/material.dart';
import 'package:jewelshop/screens/order_screen.dart';
import 'package:jewelshop/screens/user_produc_screen.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({Key? key}) : super(key: key);

  @override
  _MydrawerState createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(" "),
                  accountEmail: Text(""),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(''),
                  ),
                  onDetailsPressed: () {},
                  arrowColor: Colors.black,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(padding: EdgeInsets.all(20)),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  contentPadding: EdgeInsets.all(20),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  selected: true,
                  dense: true,
                  selectedTileColor: Colors.white,
                  subtitle: Text("click to go homepage "),
                ),
                ListTile(
                  leading: Icon(Icons.mode_edit),
                  title: Text("Manage Products"),
                  contentPadding: EdgeInsets.all(20),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(UserProductScreen.routename);
                  },
                  dense: true,
                ),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text("Orders"),
                  contentPadding: EdgeInsets.all(20),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OrderScreen.routeName);
                  },
                  dense: true,
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  contentPadding: EdgeInsets.all(20),
                  onTap: () {},
                  dense: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

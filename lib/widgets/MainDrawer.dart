import 'package:flutter/material.dart';
import '../screens/OrdersScreen.dart';
import '../screens/user_product_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Da Shawp',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag,
              size: 35,
            ),
            title: Text(
              'Shop',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt,
              size: 35,
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.edit,
              size: 35,
            ),
            title: Text(
              'Manage Products',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

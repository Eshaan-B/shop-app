import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/CartItem.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme
                        .of(context)
                        .accentColor,
                  ),
                  FlatButton(
                      textColor: Theme
                          .of(context)
                          .primaryColor,
                      onPressed: () {
                        Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);
                        cart.emptyCart();
                      },
                      child: Text('Place order'), 
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, index) {
                return CartItem(
                  productId: cart.items.keys.toList()[index],
                  price: cart.items.values.toList()[index].price,
                  title: cart.items.values.toList()[index].title,
                  id: cart.items.values.toList()[index].id,
                  quantity: cart.items.values.toList()[index].quantity,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

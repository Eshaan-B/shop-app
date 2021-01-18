import 'package:flutter/material.dart';
import '../widgets/MainDrawer.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
class OrdersScreen extends StatelessWidget {
  static const routeName='/orderScreen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your orders'),),
      drawer: MainDrawer(),
      body: ListView.builder(itemCount:orderData.orders.length ,itemBuilder: (ctx,index){
        return OrderItem(orderData.orders[index]);
      }),
    );
  }
}

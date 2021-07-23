import 'package:flutter/material.dart';
import '../widgets/MainDrawer.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orderScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;
  bool _isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_isInit) {
      _isInit=true;
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false)
          .fetchAndSetOrders()
          .catchError((onError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("An error occured")));
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: MainDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (orderData.orders.length == 0)
              ? Center(
                  child: Text("No orders yet!"),
                )
              : ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, index) {
                    return OrderItem(orderData.orders[index]);
                  }),
    );
  }
}

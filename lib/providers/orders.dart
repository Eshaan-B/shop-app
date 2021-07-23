import 'package:flutter/foundation.dart';
import 'cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id, this.amount, this.products, this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    const url = "https://shopapp-2417e-default-rtdb.firebaseio.com/orders.json";
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<OrderItem> loadedOrders = [];
      if (extractedData == null) {
        _orders = [];
        notifyListeners();
        return;
      }
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['timestamp']),
            products: (orderData['products'] as List<dynamic>)
                .map((product) {
              return CartItem(
                id: product['id'],
                title: product['title'],
                price: product['price'],
                quantity: product['quantity'],
              );
            }).toList(),
          ),
        );
      });

      //_orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (err) {
      print("===========================");
      print("ERROR IS--");
      print(err);
      throw err;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    DateTime timestamp = DateTime.now();
    const url = "https://shopapp-2417e-default-rtdb.firebaseio.com/orders.json";
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'timestamp': timestamp.toIso8601String(),
          'products': cartProducts.map((cp) {
            return {
              'id': cp.id,
              'title': cp.title,
              'quantity': cp.quantity,
              'price': cp.price,
            };
          }).toList(),
        }),
      );
      //print(response.body);
      _orders.insert(
        0,
        OrderItem(
            id: jsonDecode(response.body)['name'],
            amount: total,
            dateTime: timestamp,
            products: cartProducts),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

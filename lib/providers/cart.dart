import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({this.id, this.title, this.quantity, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  int get itemCount {
    int sum = 0;
    _items.forEach((key, value) {
      sum += value.quantity;
    });
    return sum;
  }

  Map<String, CartItem> get items {
    return _items;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                title: existingCartItem.title,
                price: existingCartItem.price,
                id: existingCartItem.id,
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              price: price,
              title: title,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeSingleItem(id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].quantity > 1) {
      _items.update(id, (existingCartItem) {
        return CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity-1);
      });
    } else {
      _items.remove(id);
    }

    notifyListeners();
  }

  void removeItem(id) {
    _items.remove(id);
    notifyListeners();
  }

  void emptyCart() {
    _items = {};
    notifyListeners();
  }
}

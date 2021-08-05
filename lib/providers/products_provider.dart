import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    //   Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   ),
    //   Product(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl:
    //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   ),
    //   Product(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ),
  ];
  var _showFavourites = false;

  Future<void> fetchAndSetProducts() async {
    const url =
        "https://shopapp-2417e-default-rtdb.firebaseio.com/products.json";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData != null)
        extractedData.forEach((key, value) {
          loadedProducts.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavourite: value['isFavourite'],
          ));
        });

      print(json.decode(response.body));

      _items = loadedProducts;

      notifyListeners();
      // print(json.decode(response.body));
    } catch (error) {
      print("BROOOOOO ERRORRRR");
      print(error);
      throw(error.toString());
    }
  }

  List<Product> get favouriteItems {
    return items.where((prodItem) => prodItem.isFavourite).toList();
  }

  List<Product> get items {
    if (_showFavourites) {
      return items.where((product) => product.isFavourite).toList();
    } else {
      return [..._items];
    }
  }

  Product findById(String id) {
    return items.firstWhere((product) => id == product.id);
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shopapp-2417e-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex =
    _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    print('index is $existingProductIndex');
    _items.removeWhere((element) => element.id == id);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException(message: "An error occurred");
    } else {
      existingProduct = null;
    }
  }

  Future<void> add(Product product) async {
    const url =
        'https://shopapp-2417e-default-rtdb.firebaseio.com/products.json';
    try {
      dynamic response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        }),
      );
      print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
      );
      _items.add(newProduct); //at the start of list
      notifyListeners();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> updateProduct(Product newProduct) async {
    final prodIndex =
    _items.indexWhere((element) => element.id == newProduct.id);
    if (prodIndex > 0) {
      final url =
          "https://shopapp-2417e-default-rtdb.firebaseio.com/products/${newProduct.id}.json";
      await http.patch(url,
          body: json.encode({
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'title': newProduct.title,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('Product not found');
    }
  }
}

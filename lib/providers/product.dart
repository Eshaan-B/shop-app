import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavourite;

  void _setFavValue(bool isFav){
    isFavourite=isFav;
    notifyListeners();
  }

  Future<void> toggleFavourite() async{
    bool oldStatus=isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url="https://shopapp-2417e-default-rtdb.firebaseio.com/products/${this.id}.json";
    try {
      final response =  await http.patch(url, body: json.encode({
        'isFavourite': this.isFavourite,
      }));
      if(response.statusCode>=400){
        _setFavValue(oldStatus);
      }
    }catch(error){
      print(error);
      _setFavValue(oldStatus);
      throw error;
    }
    notifyListeners();
  }

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavourite = false
      });
}

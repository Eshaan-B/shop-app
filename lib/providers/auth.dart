import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuthenticated {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> signIn(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBRnHbW0PL43daMwpKLHy2ul8xT4TCdyxQ");
    try {
      final extractedData = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      debugPrint(extractedData.body);
      final res = json.decode(extractedData.body);
      //print(res);
      if (res['error'] != null) {
        throw HttpException(message: res['error']['message']);
      }
      _token = res['idToken'];
      _userId = res['localId'];
      _expiryDate = DateTime.now().add(Duration(
        seconds: int.parse(res['expiresIn']),
      ));
    } catch (err) {
      print("Some error occurred");
      throw err;
    }
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBRnHbW0PL43daMwpKLHy2ul8xT4TCdyxQ");
    final extractedData = await http
        .post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    )
        .catchError((err) {
      throw err;
    });
    final res = json.decode(extractedData.body);
    _token = res['idToken'];
    _userId = res['localId'];
    _expiryDate = DateTime.now().add(Duration(
      seconds: int.parse(res['expiresIn']),
    ));
    debugPrint(extractedData.body);
    print(res);
    notifyListeners();
  }
}

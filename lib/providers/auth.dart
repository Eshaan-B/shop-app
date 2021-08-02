import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBRnHbW0PL43daMwpKLHy2ul8xT4TCdyxQ");
    final extractedData = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    ).catchError((err){
      throw err;
    });
    final res=json.decode(extractedData.body);
    print(res);

  }
}

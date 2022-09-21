import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> signup(String email, String password) async{
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBCthS-cif6Fix_yB5vWoVAjtLB35PEQN0';
    final response = await http.post(Uri.parse(url),body: json.encode({
      'email' : email,
      'password' : password,
      'returnSecureToken' : true,
    },),);
    print(json.decode(response.body));
  }
}
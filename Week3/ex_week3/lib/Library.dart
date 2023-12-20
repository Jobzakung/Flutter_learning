import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Login {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? saveUsername;

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  Future<void> login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
    prefs.setBool('isLoggedIn', true);

    if (username == 'admin' && password == 'passwd') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      prefs.setString('password', password);
      prefs.setBool('isLoggedIn', true);
    } else {
      throw Exception('Invalid username or password');
    }
  }

  Future<String?> getSavedUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> LoadUsername() async {
    saveUsername = await getSavedUsername();
  }

  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
  }
}

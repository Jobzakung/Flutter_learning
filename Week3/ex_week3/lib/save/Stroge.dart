// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:ex_week3/Count.dart';

// class Login {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final BuildContext context;

//   Login(this.context);

//   void _handleLogin() async {
//     String username = _usernameController.text;
//     String password = _passwordController.text;

//     String passEmail = 'admin';
//     String passwd = 'passwd';

//     // Perform your login logic here (e.g., API call, validation)

//     // Simulate a successful login for demonstration purposes
//     if (username == passEmail && password == passwd) {
//       // Save email and password to SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString('email', username);
//       prefs.setString('password', password);

//       // Save login status to SharedPreferences
//       prefs.setBool('isLoggedIn', true);

//       // Navigate to the home page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => Count()),
//       );
//     } else {
//       // Display an error message for unsuccessful login
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invalid username or password'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
// }

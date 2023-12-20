// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final Login _login = Login();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Form'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _login._usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _login._passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Call the _handleLogin() method when the button is pressed
//                 _login._handleLogin();
//               },
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void main() {
//     runApp(MaterialApp(
//       home: Login(),
//     ));
//   }
// }

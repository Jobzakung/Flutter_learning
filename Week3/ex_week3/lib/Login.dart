import 'package:ex_week3/Profile.dart';
import 'package:flutter/material.dart';
import 'package:ex_week3/Library.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Login _login = Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _login.usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _login.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _login.login();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid username or password'),
                    ),
                  );
                  print("Login Failed: $e");
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _login.dispose();
    super.dispose();
  }
}

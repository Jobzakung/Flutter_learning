import 'package:flutter/material.dart';
import 'package:ex_week3/Library.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;
  final Login _login = Login();

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _counter = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt('counter', counter).then((bool success) {
        return counter;
      });
    });
  }

  Future<void> _loadUsername() async {
    await _login.LoadUsername(); // Load the username from SharedPreferences
    setState(() {}); // Refresh the UI to reflect the loaded username
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${_login.saveUsername ?? 'Guest'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('Increment Counter'),
            ),
            SizedBox(height: 10),
            FutureBuilder<int>(
              future: _counter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text('Button pressed ${snapshot.data} times');
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

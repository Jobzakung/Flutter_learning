import 'package:flutter/material.dart';
import 'package:json/Covert.dart';
import 'package:json/loadJson.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Quiz>> futureQuizList;

  @override
  void initState() {
    super.initState();
    futureQuizList = loadQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quiz App'),
      ),
      body: Center(
        child: FutureBuilder<List<Quiz>>(
          future: futureQuizList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var quiz in snapshot.data!)
                    Card(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              quiz.question,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          for (var i = 0; i < quiz.choices.length; i++)
                            RadioListTile<int>(
                              title: Text(quiz.choices[i]),
                              value: i,
                              groupValue:
                                  null, // Set groupValue based on user selection
                              onChanged: (value) {
                                // Handle user selection
                              },
                            ),
                        ],
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      // Calculate and display the score
                    },
                    child: Text('Calculate Score'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

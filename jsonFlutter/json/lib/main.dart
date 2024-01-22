import 'package:flutter/material.dart';

import 'Covert.dart';

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
  List<int?> userSelections = [];
  int currentIndex = 0;
  int totalScore = 0;
  late List<Quiz> snapshotData; // Store snapshot data at class level

  @override
  void initState() {
    super.initState();
    futureQuizList = loadQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Quiz App'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Quiz'),
              Tab(text: 'Statistics'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildQuizTab(),
            buildStatisticsTab(),
          ],
        ),
      ),
    );
  }

  Widget buildQuizTab() {
    return Center(
      child: FutureBuilder<List<Quiz>>(
        future: futureQuizList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshotData = snapshot.data!; // Store snapshot data
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          snapshotData[currentIndex].id,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      for (var j = 0;
                          j < snapshotData[currentIndex].options.length;
                          j++)
                        RadioListTile<int>(
                          title: Text(snapshotData[currentIndex].options[j]),
                          value: j,
                          groupValue: userSelections.length > currentIndex
                              ? userSelections[currentIndex]
                              : null,
                          onChanged: (value) {
                            setState(() {
                              if (userSelections.length <= currentIndex) {
                                userSelections.add(value);
                              } else {
                                userSelections[currentIndex] = value;
                              }
                            });
                          },
                        ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    calculateAndShowScore();
                  },
                  child: Text('Submit Answer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    switchToNextQuestion();
                  },
                  child: Text('Switch Question'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget buildStatisticsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Latest Score: $totalScore'),
          // Add other statistics or history display here
        ],
      ),
    );
  }

  void calculateAndShowScore() {
    // Check if the user has answered the current question
    if (userSelections[currentIndex] == null) {
      // Handle incomplete quiz
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incomplete Quiz'),
            content:
                Text('Please answer the current question before submitting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    int? userAnswer = userSelections[currentIndex];
    String correctAnswer = snapshotData[currentIndex].correctAnswer;

    // Display the score
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String result = 'Incorrect';
        if (userAnswer != null &&
            userAnswer ==
                snapshotData[currentIndex].options.indexOf(correctAnswer)) {
          result = 'Correct';
          totalScore++;
        }
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('Your answer is $result. Total Score: $totalScore'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                switchToNextQuestion();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void switchToNextQuestion() {
    if (currentIndex < snapshotData.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      setState(() {
        currentIndex = 0;
        userSelections = List<int?>.filled(
            snapshotData.length, null); // Reset user selections for new quiz
      });
    }
  }
}

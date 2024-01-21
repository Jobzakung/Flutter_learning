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
  List<int?> userSelections = [];
  int currentIndex = 0;
  int totalScore = 0;

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
                          snapshot.data![currentIndex].question,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      for (var j = 0;
                          j < snapshot.data![currentIndex].choices.length;
                          j++)
                        RadioListTile<int>(
                          title: Text(snapshot.data![currentIndex].choices[j]),
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
                    calculateAndShowScore(snapshot.data![currentIndex]);
                  },
                  child: Text('Submit Answer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    switchToNextQuestion(snapshot.data!.length);
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

  void calculateAndShowScore(Quiz currentQuiz) {
    if (userSelections.length != (futureQuizList as List<Quiz>).length) {
      // Handle incomplete quiz
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incomplete Quiz'),
            content: Text('Please answer all questions before submitting.'),
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

    int correctAnswer = currentQuiz.correctIndex;

    // Display the score
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String result = 'Incorrect';
        if (userSelections[currentIndex] == correctAnswer) {
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
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void switchToNextQuestion(int totalQuestions) {
    setState(() {
      currentIndex = (currentIndex + 1) % totalQuestions;
      userSelections.add(null); // Reset the selection for the new question
    });
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  late List<String> questions;
  late List<List<String>> options;
  late List<int> correctAnswers;
  late List<int?> userAnswers;
  int score = 0;

  @override
  void initState() {
    super.initState();
    questions = [
      'What is the capital of France?',
      'Who is the president of the United States?',
      'What is the largest planet in our solar system?',
      'What is the currency of Japan?',
    ];
    options = [
      ['Paris', 'Berlin', 'London', 'Madrid'],
      ['Joe Biden', 'Donald Trump', 'Barack Obama', 'George Washington'],
      ['Jupiter', 'Saturn', 'Mars', 'Earth'],
      ['Yen', 'Won', 'Euro', 'Dollar'],
    ];
    correctAnswers = [0, 0, 1, 0];
    userAnswers = List.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questions[_currentIndex],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                options[_currentIndex].length,
                (index) => ElevatedButton(
                  onPressed: userAnswers[_currentIndex] == null
                      ? () => _answerQuestion(index)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: userAnswers[_currentIndex] != null
                        ? (userAnswers[_currentIndex] == index
                            ? Colors.green
                            : Colors.grey)
                        : null,
                  ),
                  child: Text(options[_currentIndex][index]),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed:
                      _currentIndex > 0 ? () => _changeQuestion(-1) : null,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _currentIndex < questions.length - 1
                      ? () => _changeQuestion(1)
                      : null,
                  child: Text('Next'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Select Question Index:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                questions.length,
                (index) => ElevatedButton(
                  onPressed: () => _goToQuestion(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _currentIndex == index ? Colors.blue : null,
                  ),
                  child: Text('${index + 1}'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Score: $score'),
          ],
        ),
      ),
    );
  }

  void _answerQuestion(int selectedIndex) {
    setState(() {
      userAnswers[_currentIndex] = selectedIndex;
      if (correctAnswers[_currentIndex] == selectedIndex) {
        score++;
      }
    });
  }

  void _changeQuestion(int offset) {
    setState(() {
      _currentIndex += offset;
    });
  }

  void _goToQuestion(int questionIndex) {
    setState(() {
      _currentIndex = questionIndex;
    });
  }
}

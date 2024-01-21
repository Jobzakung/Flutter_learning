import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(tabs: [
          Tab(text: "1"),
          Tab(text: "2"),
          Tab(text: "3"),
          Tab(text: "4"),
          Tab(text: "5")
        ]),
        title: Text("My Quiz"),
      ),
      body: Text("Quiz"),
    );
  }
}

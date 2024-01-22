import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:json/Covert.dart';

Future<List<Quiz>> loadData() async {
  String jsonString = await rootBundle.loadString('assets/json/data.json');
  Map<String, dynamic> jsonData = json.decode(jsonString);

  List<dynamic> questions = jsonData['questions'];

  return questions.map((quiz) => Quiz.fromJson(quiz)).toList();
}

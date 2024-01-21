import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:json/Covert.dart';

Future<List<Quiz>> loadQuizData() async {
  String jsonString = await rootBundle.loadString('assets/json/data.json');
  List<dynamic> jsonData = json.decode(jsonString);

  return jsonData.map((quiz) => Quiz.fromJson(quiz)).toList();
}

class Quiz {
  late String id;
  late List<String> options;
  late String correctAnswer;

  Quiz({
    required this.id,
    required this.options,
    required this.correctAnswer,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      options: List<String>.from(json['options']),
      correctAnswer: json['correct_answer'],
    );
  }
}

// ...

// Future<List<Quiz>> loadQuizData() async {
//   String jsonString = await rootBundle.loadString('assets/json/data.json');
//   Map<String, dynamic> jsonData = json.decode(jsonString);

//   List<dynamic> questions = jsonData['questions'];

//   return questions.map((quiz) => Quiz.fromJson(quiz)).toList();
// }

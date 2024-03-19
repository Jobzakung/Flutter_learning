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

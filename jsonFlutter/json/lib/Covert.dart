class Quiz {
  late String question;
  late List<String> choices;
  late final int correctIndex;

  Quiz({
    required this.question,
    required this.choices,
    required this.correctIndex,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      question: json['question'],
      choices: List<String>.from(json['choices']),
      correctIndex: json['correctIndex'],
    );
  }
}

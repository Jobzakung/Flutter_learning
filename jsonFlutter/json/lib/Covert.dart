class Quiz {
  final String title;
  final List<Choice> choices;
  final int answerId;

  Quiz({
    required this.title,
    required this.choices,
    required this.answerId,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    List<dynamic> choicesJson = json['choice'];

    return Quiz(
      title: json['title'],
      choices: choicesJson.map((choice) => Choice.fromJson(choice)).toList(),
      answerId: json['answerId'],
    );
  }
}

class Choice {
  final int id;
  final String title;

  Choice({
    required this.id,
    required this.title,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      id: json['id'],
      title: json['title'],
    );
  }
}

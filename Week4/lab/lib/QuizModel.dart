import 'dart:convert';

List<QuizModel> quizModelFromJson(String str) =>
    List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

String quizModelToJson(List<QuizModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
  String title;
  List<Choice> choices;
  int answerId;

  QuizModel({
    required this.title,
    required this.choices,
    required this.answerId,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        title: json["title"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        answerId: json["answerID"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "answerID": answerId,
      };
}

class Choice {
  int id;
  String title;

  Choice({
    required this.id,
    required this.title,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

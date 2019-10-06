import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Answer {
  Answer({
    this.id,
    this.text,
    this.letter,
    this.image,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  final String id;
  final String text;
  final String letter;
  final String image;

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

@JsonSerializable()
class Question {
  Question({
    this.id,
    this.title,
    this.answers,
    this.position,
    this.answer,
    this.code,
    this.tag,
    this.rightAnswer,
    this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  final String id;
  final String title;
  final List<Answer> answers;
  final int position;
  final String answer;
  final String code;
  final String tag;
  final String rightAnswer;
  final String explanation;

  bool isRightAnswer(Answer answer) =>
      rightAnswer != null && rightAnswer == answer.id;

  bool isWrongUserAnswer(Answer answer) =>
      rightAnswer != null &&
      this.answer == answer.id &&
      this.answer != rightAnswer;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

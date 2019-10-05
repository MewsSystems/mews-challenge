// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    id: json['id'] as String,
    text: json['text'] as String,
    letter: json['letter'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'letter': instance.letter,
      'image': instance.image,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'] as String,
    title: json['title'] as String,
    answers: (json['answers'] as List)
        ?.map((e) =>
            e == null ? null : Answer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    position: json['position'] as int,
    answer: json['answer'] as String,
    code: json['code'] as String,
    tag: json['tag'] as String,
    rightAnswer: json['rightAnswer'] as String,
    explanation: json['explanation'] as String,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'answers': instance.answers,
      'position': instance.position,
      'answer': instance.answer,
      'code': instance.code,
      'tag': instance.tag,
      'rightAnswer': instance.rightAnswer,
      'explanation': instance.explanation,
    };

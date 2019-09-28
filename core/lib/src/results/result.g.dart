// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    userId: json['userId'] as String,
    start: parseDateTime(json['start'] as DateTime),
    end: parseDateTime(json['end'] as DateTime),
    name: json['name'] as String,
    rightAnswerCount: json['rightAnswerCount'] as int,
    questionCount: json['questionCount'] as int,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'userId': instance.userId,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'name': instance.name,
      'rightAnswerCount': instance.rightAnswerCount,
      'questionCount': instance.questionCount,
    };

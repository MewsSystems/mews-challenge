// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameNew _$GameNewFromJson(Map<String, dynamic> json) {
  return GameNew(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$GameNewToJson(GameNew instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };

GameInProgress _$GameInProgressFromJson(Map<String, dynamic> json) {
  return GameInProgress(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    start: parseDateTime(json['start'] as DateTime),
    questionCount: json['questionCount'] as int,
  );
}

Map<String, dynamic> _$GameInProgressToJson(GameInProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start': instance.start?.toIso8601String(),
      'questionCount': instance.questionCount,
    };

RightAnswersByTags _$RightAnswersByTagsFromJson(Map<String, dynamic> json) {
  return RightAnswersByTags(
    design: json['DESIGN'] as int,
    backend: json['C#'] as int,
    frontend: json['JS'] as int,
    mobile: json['DART'] as int,
    data: json['DATA'] as int,
  );
}

Map<String, dynamic> _$RightAnswersByTagsToJson(RightAnswersByTags instance) =>
    <String, dynamic>{
      'DESIGN': instance.design,
      'C#': instance.backend,
      'JS': instance.frontend,
      'DART': instance.mobile,
      'DATA': instance.data,
    };

GameCompleted _$GameCompletedFromJson(Map<String, dynamic> json) {
  return GameCompleted(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    start: parseDateTime(json['start'] as DateTime),
    end: parseDateTime(json['end'] as DateTime),
    questionCount: json['questionCount'] as int,
    rightAnswerCount: json['rightAnswerCount'] as int,
    rightAnswersByTags: json['rightAnswersByTags'] == null
        ? null
        : RightAnswersByTags.fromJson(
            json['rightAnswersByTags'] as Map<String, dynamic>),
    showRightAnswers: json['showRightAnswers'] as bool,
  );
}

Map<String, dynamic> _$GameCompletedToJson(GameCompleted instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'questionCount': instance.questionCount,
      'rightAnswerCount': instance.rightAnswerCount,
      'rightAnswersByTags': instance.rightAnswersByTags,
      'showRightAnswers': instance.showRightAnswers,
    };

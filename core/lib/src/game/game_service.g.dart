// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameInfo _$GameInfoFromJson(Map<String, dynamic> json) {
  return GameInfo(
    id: json['id'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$GameInfoToJson(GameInfo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

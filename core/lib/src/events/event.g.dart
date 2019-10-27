// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    eventId: json['eventId'] as String,
    description: json['description'] as String,
    winnersDescription: json['winnersDescription'] as String,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'eventId': instance.eventId,
      'description': instance.description,
      'winnersDescription': instance.winnersDescription,
    };

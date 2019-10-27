import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  Event({this.eventId, this.description, this.winnersDescription});

  final String eventId;
  final String description;
  final String winnersDescription;

  static Event fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

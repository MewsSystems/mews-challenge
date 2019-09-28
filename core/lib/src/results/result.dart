import 'package:json_annotation/json_annotation.dart';

import '../utils.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  Result({
    this.userId,
    this.start,
    this.end,
    this.name,
    this.rightAnswerCount,
    this.questionCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  final String userId;

  @JsonKey(fromJson: parseDateTime)
  final DateTime start;

  @JsonKey(fromJson: parseDateTime)
  final DateTime end;

  final String name;
  final int rightAnswerCount;
  final int questionCount;

  Duration get duration => end.difference(start);

  String get durationString => duration.toString().split('.').first;
}

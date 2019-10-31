import 'package:json_annotation/json_annotation.dart';
import 'package:sealed_unions/sealed_unions.dart';
import 'package:sealed_unions/union_3.dart';

import '../utils.dart';

part 'game.g.dart';

abstract class Game {
  Game({this.id, this.title, this.description});

  final String id;
  final String title;
  final String description;
}

@JsonSerializable()
class GameNew extends Game {
  GameNew({
    String id,
    String title,
    String description,
  }) : super(
          id: id,
          title: title,
          description: description,
        );

  factory GameNew.fromJson(Map<String, dynamic> json) =>
      _$GameNewFromJson(json);
}

@JsonSerializable()
class GameInProgress extends Game {
  GameInProgress({
    String id,
    String title,
    String description,
    this.start,
    this.questionCount,
  }) : super(
          id: id,
          title: title,
          description: description,
        );

  factory GameInProgress.fromJson(Map<String, dynamic> json) =>
      _$GameInProgressFromJson(json);

  @JsonKey(fromJson: parseDateTime)
  final DateTime start;

  final int questionCount;
}

@JsonSerializable()
class RightAnswersByTags {
  RightAnswersByTags({
    this.design,
    this.backend,
    this.frontend,
    this.mobile,
    this.data,
  });

  factory RightAnswersByTags.fromJson(Map<String, dynamic> json) =>
      _$RightAnswersByTagsFromJson(json);

  @JsonKey(name: 'DESIGN')
  final int design;

  @JsonKey(name: 'C#')
  final int backend;

  @JsonKey(name: 'JS')
  final int frontend;

  @JsonKey(name: 'DART')
  final int mobile;

  @JsonKey(name: 'DATA')
  final int data;
}

@JsonSerializable()
class GameCompleted extends Game {
  GameCompleted({
    String id,
    String title,
    String description,
    this.start,
    this.end,
    this.questionCount,
    this.rightAnswerCount,
    this.rightAnswersByTags,
    this.showRightAnswers,
  }) : super(
          id: id,
          title: title,
          description: description,
        );

  factory GameCompleted.fromJson(Map<String, dynamic> json) =>
      _$GameCompletedFromJson(json);

  @JsonKey(fromJson: parseDateTime)
  final DateTime start;

  @JsonKey(fromJson: parseDateTime)
  final DateTime end;

  final int questionCount;

  final int rightAnswerCount;

  final RightAnswersByTags rightAnswersByTags;

  final bool showRightAnswers;

  Duration get duration => end.difference(start);

  ResultType get resultType {
    if (id == 'design') {
      if (rightAnswerCount == 20) return ResultType.designEagleEye;
      if (rightAnswerCount >= 16) return ResultType.designSuperstar;
      if (rightAnswerCount >= 10) return ResultType.designNotBad;
      return ResultType.designNotGreat;
    } else if (id == 'developer') {
      if (rightAnswerCount == 20) return ResultType.robot;
      if (rightAnswerCount >= 16) return ResultType.superstar;
      if (rightAnswerCount >= 10) return ResultType.notBad;
      if (rightAnswersByTags.frontend == 5) return ResultType.frontend;
      if (rightAnswersByTags.backend == 5) return ResultType.backend;
      if (rightAnswersByTags.data == 5) return ResultType.data;
      if (rightAnswersByTags.mobile == 5) return ResultType.mobile;
      return ResultType.other;
    } else if (questionCount == 15) {
      if (rightAnswerCount == 15) return ResultType.robot;
      if (rightAnswerCount >= 11) return ResultType.superstar;
      if (rightAnswerCount >= 8) return ResultType.notBad;
      return ResultType.other;
    }
    throw ArgumentError('Unknown game type: $id');
  }
}

enum ResultType {
  designEagleEye,
  designSuperstar,
  designNotBad,
  designNotGreat,
  robot,
  superstar,
  notBad,
  frontend,
  backend,
  data,
  mobile,
  other,
}

class GameState extends Union3Impl<GameNew, GameInProgress, GameCompleted> {
  GameState._(Union3<GameNew, GameInProgress, GameCompleted> union)
      : super(union);

  factory GameState.newGame(GameNew game) => GameState._(factory.first(game));

  factory GameState.inProgress(GameInProgress game) =>
      GameState._(factory.second(game));

  factory GameState.completed(GameCompleted game) =>
      GameState._(factory.third(game));

  static const Triplet<GameNew, GameInProgress, GameCompleted> factory =
      Triplet<GameNew, GameInProgress, GameCompleted>();

  String get id => join(_id, _id, _id);

  String get title => join(_title, _title, _title);

  String get description => join(_description, _description, _description);

  final _id = (Game game) => game.id;
  final _title = (Game game) => game.title;
  final _description = (Game game) => game.description;
}

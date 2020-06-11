import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:core/core.dart';
import 'package:dfunc/dfunc.dart';

part 'game_list_state.g.dart';

abstract class GameListState
    implements Built<GameListState, GameListStateBuilder> {
  factory GameListState([Function(GameListStateBuilder b) updates]) =
      _$GameListState;

  GameListState._();

  static void _initializeBuilder(GameListStateBuilder b) =>
      b..event = Optional.empty();

  Optional<Event> get event;

  BuiltList<GameState> get games;
}

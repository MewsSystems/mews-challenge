import 'package:core/core.dart';
import 'package:dfunc/dfunc.dart';
import 'package:equatable/equatable.dart';

part 'game_list_event.g.dart';

@sealed
abstract class GameListEvent extends Equatable with _$GameListEvent {
  const GameListEvent._();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [];
}

class Initialized extends GameListEvent {
  const Initialized() : super._();
}

class GameListUpdated extends GameListEvent {
  const GameListUpdated(this.games) : super._();

  final Iterable<GameState> games;

  @override
  List<Object> get props => [...super.props, games];
}

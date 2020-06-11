import 'dart:async';

import 'package:app_flutter/games/game_list/game_list_event.dart';
import 'package:app_flutter/games/game_list/game_list_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:core/core.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  GameListBloc(this._gameService, this._eventService, {this.eventId});

  StreamSubscription _gameListSubscription;

  final GameService _gameService;
  final EventService _eventService;
  final String eventId;

  @override
  GameListState get initialState => GameListState();

  @override
  Stream<GameListState> mapEventToState(GameListEvent event) =>
      event.match(_mapInitialized, _mapGameListUpdated);

  Stream<GameListState> _mapInitialized(Initialized event) async* {
    _gameListSubscription = _gameService
        .getGames(eventId)
        .map((games) => GameListUpdated(games))
        .listen(add);

    if (eventId != null) {
      final event = await _eventService.getEvent(eventId);
      yield state.rebuild((b) => b..event = event.toOptional());
    }
  }

  Stream<GameListState> _mapGameListUpdated(GameListUpdated event) async* {
    yield state.rebuild(
        (b) => b..games = BuiltList<GameState>(event.games).toBuilder());
  }

  @override
  Future<void> close() async {
    await _gameListSubscription?.cancel();
    await super.close();
  }
}

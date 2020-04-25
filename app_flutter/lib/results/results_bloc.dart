import 'package:app_flutter/results/results_event.dart';
import 'package:app_flutter/results/results_state.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  ResultsBloc(this._resultsService, this._gameService);

  final ResultsService _resultsService;
  final GameService _gameService;

  void onInitialized(String eventId) => add(ResultsInitialized(eventId));

  @override
  ResultsState get initialState => ResultsLoading();

  @override
  Stream<ResultsState> mapEventToState(ResultsEvent event) async* {
    yield await event.match(_mapInitialized);
  }

  Future<ResultsState> _mapInitialized(ResultsInitialized event) async {
    final games = await _gameService.getGameInfoForEvent(event.eventId);
    final data = games.map(_mapGameInfo).toList();
    return ResultsLoaded(data);
  }

  ResultsData _mapGameInfo(GameInfo g) =>
      ResultsData(game: g, results: _resultsService.results(g.id));
}

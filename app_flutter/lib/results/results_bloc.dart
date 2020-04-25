import 'package:core/core.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'results_bloc.g.dart';

@sealed
abstract class ResultsState with _$ResultsState {}

class ResultsLoading extends ResultsState {}

class ResultsLoaded extends ResultsState {
  ResultsLoaded(this.data);

  final List<ResultsData> data;
}

class ResultsData {
  ResultsData({this.game, this.results});

  final GameInfo game;
  final Stream<List<Result>> results;
}

@sealed
abstract class ResultsEvent with _$ResultsEvent {}

class ResultsInitialized extends ResultsEvent {
  ResultsInitialized(this.eventId);

  final String eventId;
}

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  ResultsBloc(this._resultsService, this._gameService);

  final ResultsService _resultsService;
  final GameService _gameService;

  @override
  ResultsState get initialState => ResultsLoading();

  @override
  Stream<ResultsState> mapEventToState(ResultsEvent event) async* {
    final state = await event.match((event) async {
      final games = await _gameService.getGameInfoForEvent(event.eventId);
      final data = games
          .map((g) => ResultsData(
                game: g,
                results: _resultsService.results(g.id),
              ))
          .toList();
      return ResultsLoaded(data);
    });
    yield state;
  }
}

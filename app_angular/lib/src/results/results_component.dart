import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/events/route_paths.dart';
import 'package:core/core.dart';

class ResultData {
  ResultData({this.game, this.results});

  final GameInfo game;
  final Stream<List<Result>> results;
}

@Component(
  selector: 'results',
  styleUrls: ['results_component.css'],
  templateUrl: 'results_component.html',
  directives: [
    NgFor,
    NgIf,
  ],
  pipes: [AsyncPipe],
)
class ResultsComponent implements OnActivate {
  ResultsComponent(this._resultsService, this._gameService);

  final ResultsService _resultsService;
  final GameService _gameService;

  List<ResultData> results = [];

  @override
  void onActivate(RouterState previous, RouterState current) {
    _connectResults(current.parameters[eventIdParam]);
  }

  Future<void> _connectResults(String eventId) async {
    final games = await _gameService.getGameInfoForEvent(eventId);
    results = games
        .map((g) => ResultData(
              game: g,
              results: _resultsService.results(g.id),
            ))
        .toList();
  }
}

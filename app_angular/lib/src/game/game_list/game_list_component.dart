import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:app_angular/src/card/card_component.dart';
import 'package:core/core.dart';

@Component(
  selector: 'game-list',
  templateUrl: 'game_list_component.html',
  directives: [
    NgFor,
    CardComponent,
    MaterialSpinnerComponent,
    NgIf,
  ],
)
class GameListComponent implements OnInit, OnDestroy {
  GameListComponent(this._service);

  StreamSubscription _subscription;

  @Input()
  String eventId;

  final GameService _service;

  List<GameState> games = [];

  @override
  Future<Null> ngOnInit() async {
    _subscription = _service.getGames(eventId).listen((d) => games = d);
  }

  @override
  void ngOnDestroy() {
    _subscription?.cancel();
  }
}

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:app_angular/src/game/app_game_service.dart';
import 'package:app_angular/src/game/current_question/current_question_component.dart';
import 'package:core/core.dart';
import 'package:rxdart/rxdart.dart';

@Component(
  selector: 'current-game',
  templateUrl: 'current_game_component.html',
  styleUrls: ['current_game_component.css'],
  directives: [NgIf, CurrentQuestionComponent],
  pipes: [commonPipes],
)
class CurrentGameComponent implements OnInit, OnDestroy {
  CurrentGameComponent(
    this._gameService,
    this._authService,
    this._appGameService,
  ) {
    timer = Observable.periodic(Duration(seconds: 1), (_) => DateTime.now())
        .startWith(DateTime.now())
        .map((now) => formatTime(now.difference(game.start)));
  }

  final GameService _gameService;
  final AuthService _authService;
  final AppGameService _appGameService;

  @Input()
  GameInProgress game;

  Stream<String> timer;

  StreamSubscription _subscription;

  Question question;

  @override
  void ngOnInit() {
    _subscription = _gameService
        .getCurrentQuestion(
          _authService.currentUser.uid,
          _appGameService.currentGameId.value,
        )
        .listen((data) => question = data);
  }

  @override
  void ngOnDestroy() {
    _subscription?.cancel();
  }
}

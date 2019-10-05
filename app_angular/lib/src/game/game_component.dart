import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/auth/login_component.dart';
import 'package:app_angular/src/game/completed_game/completed_game_component.dart';
import 'package:app_angular/src/game/current_game/current_game_component.dart';
import 'package:app_angular/src/game/game_list/game_list_component.dart';
import 'package:app_angular/src/game/new_game/new_game_component.dart';
import 'package:app_angular/src/game/route_paths.dart';
import 'package:core/core.dart';
import 'package:rxdart/rxdart.dart';

@Component(
  selector: 'game',
  templateUrl: 'game_component.html',
  directives: [
    GameListComponent,
    LoginComponent,
    NgIf,
    CurrentGameComponent,
    CompletedGameComponent,
    NewGameComponent,
  ],
)
class GameComponent implements OnActivate, OnDeactivate {
  GameComponent(this._authService, this._gameService);

  final AuthService _authService;
  final GameService _gameService;

  GameState currentGame;
  bool showLogin = false;
  String currentGameId;

  CompositeSubscription _subscription = CompositeSubscription();

  @override
  void onActivate(RouterState previous, RouterState current) {
    currentGameId = current.parameters[idParam];
    _subscription
      ..add(_gameService
          .getGame(currentGameId)
          .listen((state) => currentGame = state))
      ..add(_authService.user
          .map((u) => u != null)
          .listen((isAuthenticated) => showLogin = !isAuthenticated));
  }

  @override
  void onDeactivate(RouterState current, RouterState next) {
    _subscription.clear();
  }

  GameInProgress get gameInProgress => currentGame?.join(
        (_) => null,
        (g) => g,
        (_) => null,
      );

  GameCompleted get gameCompleted => currentGame?.join(
        (_) => null,
        (_) => null,
        (g) => g,
      );
}

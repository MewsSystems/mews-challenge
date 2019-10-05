import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_components/utils/browser/window/module.dart';
import 'package:app_angular/src/auth/login_component.dart';
import 'package:app_angular/src/auth/logout/logout_component.dart';
import 'package:app_angular/src/game/app_game_service.dart';
import 'package:app_angular/src/game/completed_game/completed_game_component.dart';
import 'package:app_angular/src/game/current_game/current_game_component.dart';
import 'package:app_angular/src/game/game_list/game_list_component.dart';
import 'package:app_angular/src/game/new_game/new_game_component.dart';
import 'package:app_angular/src/results/results_component.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:rxdart/rxdart.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'main_component.html',
  directives: [
    GameListComponent,
    LoginComponent,
    NgIf,
    CurrentGameComponent,
    CompletedGameComponent,
    MaterialButtonComponent,
    LogoutComponent,
    ResultsComponent,
    NewGameComponent,
  ],
  pipes: [commonPipes],
  providers: [
    ClassProvider(AppGameService),
  ],
)
class AppComponent {
  AppComponent(this._authService, this._gameService, this._appGameService) {
    Observable.combineLatest2(
      _authService.user.map((u) => u == null),
      _appGameService.currentGameId.map((id) => id != null),
      (bool isAuthenticated, bool isGameSelected) =>
          isAuthenticated && isGameSelected,
    ).listen((v) => showLogin = v);

    _appGameService.currentGameId.listen((id) {
      currentGameId = id;
    });

    _appGameService.currentGameId
        .map((id) => id == null)
        .listen((v) => showGameSelector = v);

    _appGameService.currentGameId
        .switchMap(_gameService.getGame)
        .listen((state) {
      currentGame = state;
    });

    _authService.user.listen((u) => user = u);
  }

  final AuthService _authService;
  final GameService _gameService;
  final AppGameService _appGameService;

  bool showLogoutDialog = false;

  void logout() {
    showLogoutDialog = true;
  }

  void closeLogoutDialog() {
    showLogoutDialog = false;
  }

  bool showLogin;

  User user;

  String get name => getFirstName(user);

  bool showGameSelector;

  GameState currentGame;

  String currentGameId;

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

  bool showResults = getWindow().location.search.contains('?results');
}

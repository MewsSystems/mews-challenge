import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/game/question/question_component.dart';
import 'package:app_angular/src/game/route_paths.dart';
import 'package:core/core.dart';
import 'package:rxdart/rxdart.dart';

@Component(
  selector: 'game-answers',
  templateUrl: 'answers_component.html',
  styleUrls: ['answers_component.css'],
  directives: [NgFor, QuestionComponent],
)
class AnswersComponent implements OnActivate, OnDeactivate {
  AnswersComponent(this._authService, this._gameService, this._router);

  final AuthService _authService;
  final GameService _gameService;
  final Router _router;

  bool showLogin = false;
  CompositeSubscription _subscription = CompositeSubscription();

  List<Question> questions = [];

  @override
  void onActivate(RouterState previous, RouterState current) {
    final currentGameId = current.parameters[idParam];
    _subscription
      ..add(_gameService.getGame(currentGameId).listen((state) {
        if (_authService.currentUser == null) return;

        if (state == null) {
          _openGamePage(currentGameId);
          return;
        }

        state.join(
          (_) => _openGamePage(currentGameId),
          (_) => _openGamePage(currentGameId),
          (g) async {
            if (g.showRightAnswers != true) {
              _openGamePage(currentGameId);
            } else {
              questions = await _gameService.getQuestions(
                _authService.currentUser.uid,
                currentGameId,
              );
            }
          },
        );
      }))
      ..add(_authService.user
          .map((u) => u != null)
          .listen((isAuthenticated) => showLogin = !isAuthenticated));
  }

  @override
  void onDeactivate(RouterState current, RouterState next) {
    _subscription.clear();
  }

  void _openGamePage(String id) {
    _router.navigate(RoutePaths.game.toUrl(parameters: {idParam: id}));
  }
}

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/game/route_paths.dart';
import 'package:core/core.dart';

@Component(
  selector: 'completed-game',
  templateUrl: 'completed_game_component.html',
  styleUrls: ['completed_game_component.css'],
  directives: [NgIf, MaterialButtonComponent, NgSwitch, NgSwitchWhen],
  pipes: [commonPipes],
  exports: [ResultType],
)
class CompletedGameComponent {
  CompletedGameComponent(this._authService, this._router);

  final AuthService _authService;
  final Router _router;

  @Input()
  GameCompleted game;

  String get userFirstName => getFirstName(_authService.currentUser);

  String get time => formatTime(game.duration);

  bool get showAnswersButton => game.showRightAnswers;

  void showRightAnswers() {
    _router
        .navigate(RoutePaths.gameAnswers.toUrl(parameters: {idParam: game.id}));
  }
}

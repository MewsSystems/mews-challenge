import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
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
  CompletedGameComponent(this._authService);

  final AuthService _authService;

  @Input()
  GameCompleted game;

  String get userFirstName => getFirstName(_authService.currentUser);

  String get time => formatTime(game.duration);
}

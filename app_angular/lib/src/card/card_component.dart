import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:app_angular/src/game/app_game_service.dart';
import 'package:core/core.dart';

@Component(
  selector: 'card',
  styleUrls: ['card_component.css'],
  templateUrl: 'card_component.html',
  directives: [MaterialButtonComponent],
)
class CardComponent {
  CardComponent(this._appGameService);

  @Input()
  GameState game;

  final AppGameService _appGameService;

  String get buttonTitle => game.join(
        (_) => 'Start game',
        (_) => 'Continue game',
        (_) => 'See results',
      );

  void startGame() {
    _appGameService.currentGameId.add(game.id);
  }
}

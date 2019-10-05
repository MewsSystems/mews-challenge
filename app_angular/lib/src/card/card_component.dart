import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/game/route_paths.dart';
import 'package:core/core.dart';

@Component(
  selector: 'card',
  styleUrls: ['card_component.css'],
  templateUrl: 'card_component.html',
  directives: [MaterialButtonComponent],
)
class CardComponent {
  CardComponent(this._router);

  @Input()
  GameState game;

  final Router _router;

  String get buttonTitle => game.join(
        (_) => 'Start game',
        (_) => 'Continue game',
        (_) => 'See results',
      );

  void startGame() {
    _router.navigate(RoutePaths.game.toUrl(parameters: {idParam: game.id}));
  }
}

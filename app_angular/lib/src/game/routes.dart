import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/game/answers/answers_component.template.dart' as answers_template;
import 'package:app_angular/src/game/game_list/game_list_component.template.dart' as game_list_template;
import 'package:app_angular/src/game/game_component.template.dart' as game_template;
import 'package:app_angular/src/game/route_paths.dart';

class Routes {
  static final games = RouteDefinition(
    routePath: RoutePaths.games,
    component: game_list_template.GameListComponentNgFactory,
  );

  static final game = RouteDefinition(
    routePath: RoutePaths.game,
    component: game_template.GameComponentNgFactory,
  );

  static final gameAnswers = RouteDefinition(
    routePath: RoutePaths.gameAnswers,
    component: answers_template.AnswersComponentNgFactory,
  );

  static final all = [
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.games.toUrl(),
    ),
    games,
    game,
    gameAnswers,
  ];
}

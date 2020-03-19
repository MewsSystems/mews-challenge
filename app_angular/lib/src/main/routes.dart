import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/events/routes.dart' as events;
import 'package:app_angular/src/game/game_list/game_list_component.template.dart'
    as main_template;
import 'package:app_angular/src/game/routes.dart' as game;
import 'package:app_angular/src/route_paths.dart';

class Routes {
  static final root = RouteDefinition(
    routePath: RoutePaths.root,
    component: main_template.GameListComponentNgFactory,
  );

  static final all = [
    root,
    ...events.Routes.all,
    ...game.Routes.all,
  ];
}

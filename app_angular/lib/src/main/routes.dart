import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/events/route_paths.dart' as events_route;
import 'package:app_angular/src/events/routes.dart' as events;
import 'package:app_angular/src/game/routes.dart' as game;

class Routes {
  static final all = [
    RouteDefinition.redirect(
      path: '',
      redirectTo: events_route.RoutePaths.event
          .toUrl(parameters: {events_route.eventIdParam: 'webexpo2019'}),
    ),
    ...events.Routes.all,
    ...game.Routes.all,
  ];
}

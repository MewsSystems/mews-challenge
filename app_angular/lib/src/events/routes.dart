import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/events/event_component.template.dart'
    as event_template;
import 'package:app_angular/src/events/route_paths.dart';

class Routes {
  static final event = RouteDefinition(
    routePath: RoutePaths.event,
    component: event_template.EventComponentNgFactory,
  );

  static final all = [
    event,
  ];
}

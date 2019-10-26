import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/events/route_paths.dart';

class RoutePaths {
  static final root = RoutePath(path: '');
  static final games = RoutePath(path: 'games');
  static final events = RoutePath(path: 'events');
  static final results = RoutePath(path: 'results/:$eventIdParam');
}

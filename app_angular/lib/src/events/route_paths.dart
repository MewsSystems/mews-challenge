import 'package:angular_router/angular_router.dart';

const eventIdParam = 'id';

class RoutePaths {
  static final event = RoutePath(
    path: 'events/:$eventIdParam',
  );
}

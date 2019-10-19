import 'package:angular_router/angular_router.dart';

import '../route_paths.dart' as _parent;

const eventIdParam = 'id';

class RoutePaths {
  static final event = RoutePath(
    path: 'events/:$eventIdParam',
    parent: _parent.RoutePaths.root,
  );
}

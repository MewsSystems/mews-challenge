import 'package:angular_router/angular_router.dart';

import '../route_paths.dart' as _parent;

const idParam = 'id';

class RoutePaths {
  static final games = RoutePath(
    path: 'games',
    parent: _parent.RoutePaths.root,
  );

  static final game = RoutePath(
    path: 'games/:$idParam',
    parent: _parent.RoutePaths.root,
  );

  static final gameAnswers = RoutePath(
    path: 'games/:$idParam/answers',
    parent: _parent.RoutePaths.root,
  );
}

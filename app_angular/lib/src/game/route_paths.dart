import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class RoutePaths {
  static final game = RoutePath(
    path: 'games/:$idParam',
  );

  static final gameAnswers = RoutePath(
    path: 'games/:$idParam/answers',
  );
}

import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/main/main_component.template.dart'
    as main_template;
import 'package:app_angular/src/results/results_component.template.dart'
    as results_template;
import 'package:app_angular/src/route_paths.dart';

class Routes {
  static final root = RouteDefinition(
    routePath: RoutePaths.root,
    component: main_template.MainComponentNgFactory,
  );

  static final results = RouteDefinition(
    routePath: RoutePaths.results,
    component: results_template.ResultsComponentNgFactory,
  );

  static final all = [
    root,
    results,
  ];
}

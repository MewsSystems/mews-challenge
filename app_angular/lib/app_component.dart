import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/main/main_component.template.dart'
    as main_template;
import 'package:app_angular/src/results/results_component.template.dart'
    as results_template;

class RoutePaths {
  static final root = RoutePath(path: '/');
  static final results = RoutePath(path: '/results');
}

class Routes {
  static final root = RouteDefinition(
    routePath: RoutePaths.root,
    component: main_template.AppComponentNgFactory,
  );

  static final results = RouteDefinition(
    routePath: RoutePaths.results,
    component: results_template.ResultsComponentNgFactory,
  );

  static final all = [root, results];
}

@Component(
  selector: 'my-app',
  template: '<router-outlet [routes]="Routes.all"></router-outlet>',
  directives: [routerDirectives],
  exports: [RoutePaths, Routes],
)
class AppComponent {}

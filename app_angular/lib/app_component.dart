import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/route_paths.dart';
import 'package:app_angular/src/routes.dart';

@Component(
  selector: 'my-app',
  template: '<router-outlet [routes]="Routes.all"></router-outlet>',
  directives: [routerDirectives],
  exports: [RoutePaths, Routes],
)
class AppComponent {}

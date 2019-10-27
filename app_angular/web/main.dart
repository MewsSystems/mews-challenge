import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/app_component.template.dart' as ng;
import 'package:core/core.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  ClassProvider(AuthService),
  ClassProvider(GameService),
  ClassProvider(ResultsService),
  ClassProvider(EventService),
  routerProvidersHash,
])
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() {
  initApp();
  runApp(ng.AppComponentNgFactory, createInjector: rootInjector);
}

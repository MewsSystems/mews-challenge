import 'package:angular/angular.dart';
import 'package:core/core.dart';
import 'package:app_angular/app_component.template.dart' as ng;

import 'main.template.dart' as self;

@GenerateInjector([
  ClassProvider(AuthService),
  ClassProvider(GameService),
  ClassProvider(ResultsService),
])
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() {
  initApp();
  runApp(ng.AppComponentNgFactory, createInjector: rootInjector);
}

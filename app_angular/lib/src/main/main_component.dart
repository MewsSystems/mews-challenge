import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/auth/login_component.dart';
import 'package:app_angular/src/auth/logout/logout_component.dart';
import 'package:app_angular/src/game/routes.dart';
import 'package:app_angular/src/route_paths.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'main_component.html',
  directives: [
    LoginComponent,
    NgIf,
    LogoutComponent,
    routerDirectives,
    MaterialButtonComponent,
  ],
  exports: [RoutePaths, Routes],
  pipes: [commonPipes],
)
class AppComponent implements OnInit, OnDestroy {
  AppComponent(this._authService);

  final AuthService _authService;
  StreamSubscription _subscription;

  bool showLogoutDialog = false;

  void logout() {
    showLogoutDialog = true;
  }

  void closeLogoutDialog() {
    showLogoutDialog = false;
  }

  @override
  void ngOnInit() {
    _subscription = _authService.user.listen((u) => user = u);
  }

  User user;

  String get name => getFirstName(user);

  @override
  void ngOnDestroy() {
    _subscription?.cancel();
  }
}

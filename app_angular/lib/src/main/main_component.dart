import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:app_angular/src/auth/login_component.dart';
import 'package:app_angular/src/auth/logout/logout_component.dart';
import 'package:app_angular/src/main/routes.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';

@Component(
  selector: 'main',
  templateUrl: 'main_component.html',
  directives: [
    LoginComponent,
    NgIf,
    LogoutComponent,
    routerDirectives,
    MaterialButtonComponent,
  ],
  exports: [Routes],
  pipes: [commonPipes],
)
class MainComponent implements OnInit, OnDestroy {
  MainComponent(this._authService);

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

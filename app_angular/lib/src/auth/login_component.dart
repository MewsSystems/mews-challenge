import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';

@Component(
  selector: 'login',
  templateUrl: 'login_component.html',
  directives: [
    MaterialButtonComponent,
    MaterialCheckboxComponent,
    NgIf,
  ],
  styleUrls: ['login_component.css'],
)
class LoginComponent implements OnInit, OnDestroy {
  LoginComponent(this._authService);

  final AuthService _authService;

  User user;

  StreamSubscription _userSubscription;

  bool consentChecked = false;
  bool isAuthenticating = false;

  void loginFB() async {
    isAuthenticating = true;
    await _authService.loginFacebook();
    isAuthenticating = false;
  }

  void login() async {
    isAuthenticating = true;
    await _authService.loginGoogle();
    isAuthenticating = false;
  }

  void logout() {
    _authService.logout();
  }

  @override
  void ngOnDestroy() {
    _userSubscription?.cancel();
  }

  @override
  void ngOnInit() {
    _userSubscription = _authService.user.listen((u) => user = u);
  }
}

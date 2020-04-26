import 'dart:async';

import 'package:app_flutter/auth/login_event.dart';
import 'package:app_flutter/auth/login_state.dart';
import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(AuthService authService) : _authService = authService;

  final AuthService _authService;

  void onConsentTriggered() =>
      add(LoginEvent.consentGiven(!state.isConsentGiven));

  void onLoginRequested(AuthMethod method) =>
      add(LoginEvent.loginRequested(method));

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) => event.match(
        _mapLogInConsentGiven,
        _mapLogInRequested,
        (LoginSucceeded e) => Stream.value(LoginState.success()),
      );

  Stream<LoginState> _mapLogInConsentGiven(LoginConsentGiven event) async* {
    yield event.isGiven ? LoginState.ready() : LoginState.initial();
  }

  Stream<LoginState> _mapLogInRequested(LoginRequested event) async* {
    yield LoginState.inProgress();
    User user;
    switch (event.method) {
      case AuthMethod.google:
        user = await _authService.loginGoogle();
        break;
      case AuthMethod.facebook:
        user = await _authService.loginFacebook();
        break;
    }
    yield user == null ? LoginState.ready() : LoginState.success();
  }
}

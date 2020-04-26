import 'package:dfunc/dfunc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.g.dart';

@sealed
abstract class LoginState extends Equatable with _$LoginState {
  const LoginState._();

  @override
  List<Object> get props => [];

  factory LoginState.initial() => const LoginInitial._();

  factory LoginState.ready() => const LoginReady._();

  factory LoginState.inProgress() => const LoginInProgress._();

  factory LoginState.success() => const AuthSuccess._();

  bool get isConsentGiven => match(F, T, T, T);

  bool get isConsentEnabled => match(T, T, F, F);

  bool get isLoginEnabled => match(F, T, F, F);

  @override
  bool get stringify => true;
}

class LoginInitial extends LoginState {
  const LoginInitial._() : super._();
}

class LoginReady extends LoginState {
  const LoginReady._() : super._();
}

class LoginInProgress extends LoginState {
  const LoginInProgress._() : super._();
}

class AuthSuccess extends LoginState {
  const AuthSuccess._() : super._();
}

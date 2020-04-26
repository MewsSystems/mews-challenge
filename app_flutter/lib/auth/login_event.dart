import 'package:dfunc/dfunc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.g.dart';

@sealed
abstract class LoginEvent extends Equatable with _$LoginEvent {
  const LoginEvent._();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [];

  factory LoginEvent.loginRequested(AuthMethod method) =>
      LoginRequested._(method);

  factory LoginEvent.loggedIn() => const LoginSucceeded._();

  factory LoginEvent.consentGiven(bool isGiven) => LoginConsentGiven._(isGiven);
}

enum AuthMethod { google, facebook }

class LoginConsentGiven extends LoginEvent {
  LoginConsentGiven._(this.isGiven) : super._();

  @override
  List<Object> get props => [isGiven];

  final bool isGiven;
}

class LoginRequested extends LoginEvent {
  LoginRequested._(this.method) : super._();

  final AuthMethod method;

  @override
  List<Object> get props => [method];
}

class LoginSucceeded extends LoginEvent {
  const LoginSucceeded._() : super._();
}

import '../models/authentication_model.dart';


abstract class AuthenticationEvent{
  const AuthenticationEvent();
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationModel status;
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}


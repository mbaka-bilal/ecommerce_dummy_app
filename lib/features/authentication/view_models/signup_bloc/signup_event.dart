class SignupEvent {}

class SignupEmailAndPasswordEvent extends SignupEvent {
  final String email;
  final String password;

  SignupEmailAndPasswordEvent({required this.email, required this.password});
}

class SignupGoogleEvent extends SignupEvent {}

class SignupFacebookEvent extends SignupEvent {}

import 'package:ecommerce_dummy_app/models/user_model.dart';
import 'package:equatable/equatable.dart';

enum AuthenticationStatus {
  unKnown,
  authenticated,
  unauthenticated,
  loginIn,
  loginInProgress,
  loginSuccessfully,
  signingUpInProgress,
  signUpSuccessfully,
  loginError,
  signUpError,
  forgotPasswordError,
  resettingPassword,
}


class AuthenticationModel extends Equatable{
   AuthenticationModel({
    required this.authenticationStatus,
    this.statusMessage,
    this.user,
  });

  final AuthenticationStatus authenticationStatus;
  final String? statusMessage;
  final User? user;

  @override
  List<Object?> get props => [authenticationStatus,statusMessage,user]; //authenticationStatus,
}

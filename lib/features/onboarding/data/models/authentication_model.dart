import 'package:ecommerce_dummy_app/features/profile/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

enum AuthenticationStatus {
  unKnown,
  authenticated,
  unauthenticated,
  emailNotVerified,
  loginIn,
  loginInProgress,
  loginSuccessfully,
  signingUpInProgress,
  signUpSuccessfully,
  loginError,
  signUpError,
  sendingUserConfirmationLink,
  userConfirmationLinkSent,
  errorSendingUserConfirmationLink,
  forgotPasswordError,
  resettingPasswordInProgress,
  resettingPasswordSuccessfully,
  resettingPasswordError,
}

class AuthenticationModel extends Equatable {
  AuthenticationModel({
    required this.authenticationStatus,
    this.statusMessage,
    this.user,
  });

  final AuthenticationStatus authenticationStatus;
  final String? statusMessage;
  final UserModel? user;

  @override
  List<Object?> get props => [authenticationStatus, statusMessage, user]; //authenticationStatus,
}

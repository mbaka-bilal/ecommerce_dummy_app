import 'package:equatable/equatable.dart';

import '../../data/models/authentication_model.dart';
import '../../../profile/data/models/user_model.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.authenticationModel,
  });

  AuthenticationState.unKnown()
      : this._(
            authenticationModel: AuthenticationModel(
                authenticationStatus: AuthenticationStatus.unKnown));

  AuthenticationState.authenticated()
      : this._(
          authenticationModel: AuthenticationModel(
            authenticationStatus: AuthenticationStatus.authenticated,

          ),
        );

  AuthenticationState.unAuthenticated()
      : this._(
            authenticationModel: AuthenticationModel(
                authenticationStatus: AuthenticationStatus.unauthenticated));

  // AuthenticationState.

  AuthenticationState.signingUpInProgress(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus: AuthenticationStatus.signingUpInProgress,
          statusMessage: statusMessage,
        ));

  AuthenticationState.signUpSuccessfully(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
                authenticationStatus: AuthenticationStatus.signUpSuccessfully,
                statusMessage: statusMessage));

  AuthenticationState.signUpError(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
                authenticationStatus: AuthenticationStatus.signUpError,
                statusMessage: statusMessage));

  AuthenticationState.loginInProgress(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus: AuthenticationStatus.loginInProgress,
          statusMessage: statusMessage,
        ));

  AuthenticationState.loginSuccessfully(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus: AuthenticationStatus.loginSuccessfully,
          statusMessage: statusMessage,
        ));

  AuthenticationState.loginError(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus: AuthenticationStatus.loginError,
          statusMessage: statusMessage,
        ));

  AuthenticationState.sendingUserConfirmationLink(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus:
              AuthenticationStatus.sendingUserConfirmationLink,
          statusMessage: statusMessage,
        ));

  AuthenticationState.userConfirmationLinkSent(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus: AuthenticationStatus.userConfirmationLinkSent,
              statusMessage: statusMessage,
        ));

  AuthenticationState.errorSendingUserConfirmationLink(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus:
              AuthenticationStatus.errorSendingUserConfirmationLink,
          statusMessage: statusMessage,
        ));

  AuthenticationState.emailNotVerified(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus: AuthenticationStatus.emailNotVerified,
          statusMessage: statusMessage,
        ));

  AuthenticationState.resettingPasswordInProgress(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus:
              AuthenticationStatus.resettingPasswordInProgress,
          statusMessage: statusMessage,
        ));

  AuthenticationState.resettingPasswordSuccessfully(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
                authenticationStatus:
                    AuthenticationStatus.resettingPasswordSuccessfully,
            statusMessage: statusMessage,
            ));

  AuthenticationState.resettingPasswordError(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
          authenticationStatus: AuthenticationStatus.resettingPasswordError,
          statusMessage: statusMessage,
        ));

  final AuthenticationModel authenticationModel;

  @override
  List<Object?> get props => [authenticationModel];
}

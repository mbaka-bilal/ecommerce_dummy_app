import 'package:equatable/equatable.dart';

import '../models/authentication_model.dart';
import '../models/user_model.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.authenticationModel,
  });

  AuthenticationState.unKnown()
      : this._(
            authenticationModel: AuthenticationModel(
                authenticationStatus: AuthenticationStatus.unKnown));

  AuthenticationState.authenticated(User user, String statusMessage)
      : this._(
          authenticationModel: AuthenticationModel(
            authenticationStatus: AuthenticationStatus.authenticated,
            user: user,
            statusMessage: statusMessage,
          ),
        );

  AuthenticationState.unAuthenticated()
      : this._(
            authenticationModel: AuthenticationModel(
                authenticationStatus: AuthenticationStatus.unauthenticated));

  AuthenticationState.signingUpInProgress(String statusMessage)
      : this._(
            authenticationModel: AuthenticationModel(
                authenticationStatus:
                    AuthenticationStatus.signingUpInProgress,
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

  AuthenticationState.loginInProgress(String statusMessage): this._(
      authenticationModel: AuthenticationModel(authenticationStatus: AuthenticationStatus.loginInProgress,
        statusMessage: statusMessage,
      )
  );

  AuthenticationState.loginSuccessfully(String statusMessage): this._(
    authenticationModel: AuthenticationModel(authenticationStatus: AuthenticationStatus.loginSuccessfully,
    statusMessage: statusMessage,
    )
  );

  AuthenticationState.loginError(String statusMessage): this._(
      authenticationModel: AuthenticationModel(authenticationStatus: AuthenticationStatus.loginError,
        statusMessage: statusMessage,
      )
  );



  final AuthenticationModel authenticationModel;

  @override
  List<Object?> get props => [authenticationModel];
}

import 'dart:async';

import 'package:bloc/bloc.dart' as bloc;

import 'authentication_event.dart';
import 'authentication_state.dart';

import '../models/authentication_model.dart';
import '../models/user_model.dart';
import '../repositories/authentication_respository.dart';
import '../repositories/user_repository.dart';

class AuthenticationBloc
    extends bloc.Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        // _userRepository = userRepository,
        super(AuthenticationState.unKnown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription =
        _authenticationRepository.status.listen((status) {
      add(AuthenticationStatusChanged(status));
    });
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    bloc.Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status.authenticationStatus) {
      case AuthenticationStatus.unauthenticated:
        emit(AuthenticationState.unAuthenticated());
        break;
      case AuthenticationStatus.authenticated:
        emit(AuthenticationState.authenticated());
        // final user = await _tryGetUser();
        // if (user == null) {
        //   emit(AuthenticationState.unAuthenticated());
        // } else {
        //   emit(AuthenticationState.authenticated(user, "Login Successful"));
        // }
        break;
      case AuthenticationStatus.unKnown:
        emit(AuthenticationState.unKnown());
        break;
      case AuthenticationStatus.loginInProgress:
        emit(AuthenticationState.loginInProgress(event.status.statusMessage!));
        break;
      case AuthenticationStatus.loginSuccessfully:
        emit(
            AuthenticationState.loginSuccessfully(event.status.statusMessage!));
        break;
      case AuthenticationStatus.loginError:
        emit(AuthenticationState.loginError(event.status.statusMessage!));
        break;
      case AuthenticationStatus.signingUpInProgress:
        emit(AuthenticationState.signingUpInProgress(
            event.status.statusMessage!));
        break;
      case AuthenticationStatus.signUpSuccessfully:
        emit(AuthenticationState.signUpSuccessfully(
            event.status.statusMessage!));
        break;
      case AuthenticationStatus.signUpError:
        emit(AuthenticationState.signUpError(event.status.statusMessage!));
        break;
      case AuthenticationStatus.sendingUserConfirmationLink:
        emit(AuthenticationState.sendingUserConfirmationLink(
            event.status.statusMessage!));
        break;
      case AuthenticationStatus.userConfirmationLinkSent:
        emit(AuthenticationState.userConfirmationLinkSent(
          event.status.statusMessage!,
        ));
        break;
      case AuthenticationStatus.errorSendingUserConfirmationLink:
        emit(AuthenticationState.errorSendingUserConfirmationLink(
            event.status.statusMessage!));
        break;
      case AuthenticationStatus.emailNotVerified:
        emit(AuthenticationState.emailNotVerified(event.status.statusMessage!));
        break;
      case AuthenticationStatus.resettingPasswordInProgress:
        emit(AuthenticationState.resettingPasswordInProgress(
          event.status.statusMessage!,
        ));
        break;
      case AuthenticationStatus.resettingPasswordSuccessfully:
        emit(AuthenticationState.resettingPasswordSuccessfully(
          event.status.statusMessage!,
        ));
        break;
      case AuthenticationStatus.resettingPasswordError:
        emit(AuthenticationState.resettingPasswordError(
          event.status.statusMessage!,
        ));
        break;
      default:
        break;
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    bloc.Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  final AuthenticationRepository _authenticationRepository;

  // final UserRepository _userRepository;
  late StreamSubscription<AuthenticationModel>
      _authenticationStatusSubscription;
}

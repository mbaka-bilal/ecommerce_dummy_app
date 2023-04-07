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
        _userRepository = userRepository,
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
        return emit(AuthenticationState.unAuthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        if (user == null) {
          emit(AuthenticationState.unAuthenticated());
        } else {
          emit(AuthenticationState.authenticated(user, "Login Successful"));
        }
        break;
      case AuthenticationStatus.unKnown:
        return emit(AuthenticationState.unKnown());
      case AuthenticationStatus.loginIn:
        // TODO: Handle this case.
        break;
      case AuthenticationStatus.signingUpInProgress:
        emit(AuthenticationState.signingUpInProgress("Creating your account...."));
        break;
      case AuthenticationStatus.signUpSuccessfully:
        emit(AuthenticationState.signUpSuccessfully(
            event.status.statusMessage!));
        break;
      case AuthenticationStatus.signUpError:
        emit(AuthenticationState.signUpError(
            event.status.statusMessage!));
        break;
        case AuthenticationStatus.loginError:
        // TODO: Handle this case.
        break;

      case AuthenticationStatus.forgotPasswordError:
        // TODO: Handle this case.
        break;
      case AuthenticationStatus.resettingPassword:
        // TODO: Handle this case.
        break;
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    bloc.Emitter<AuthenticationState> emit,
  ) {
    // _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationModel>
      _authenticationStatusSubscription;
}

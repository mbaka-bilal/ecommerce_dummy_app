import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/basestate.dart';
import '../../../../core/exception_handlers/app_exception_handler.dart';
import '../../../../core/exception_handlers/exception_types.dart';
import '../../domain/use_cases/signup_use_case.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required this.signupUseCase}) : super(SignupState()) {
    on<SignupEmailAndPasswordEvent>(_onSignupEmailAndPasswordEvent);
    on<SignupGoogleEvent>(_onSignupGoogleEvent);
    on<SignupFacebookEvent>(_onSignupFacebookEvent);
  }

  final SignupUseCase signupUseCase;

  Future<void> _onSignupEmailAndPasswordEvent(
    SignupEmailAndPasswordEvent event,
    Emitter<SignupState> emit,
  ) async {
    try {
      emit(SignupState.loading());

      final user = await signupUseCase.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(status: BaseState.success(), user: user));
    } catch (e) {
      emit(
        SignupState.error(errorMessage: AppExceptionHandler.handleException(e)),
      );
    }
  }

  Future<void> _onSignupGoogleEvent(
    SignupGoogleEvent event,
    Emitter<SignupState> emit,
  ) async {
    try {
      emit(SignupState.loading(isGoogleSignIn: true));

      final user = await signupUseCase.signInWithGoogle();

      emit(state.copyWith(status: BaseState.success(), user: user));
    } catch (e) {
      if (e is GoogleSignInAbortedException) {
        emit(SignupState());
        return;
      }

      emit(
        SignupState.error(errorMessage: AppExceptionHandler.handleException(e)),
      );
    }
  }

  Future<void> _onSignupFacebookEvent(
    SignupFacebookEvent event,
    Emitter<SignupState> emit,
  ) async {
    try {
      emit(SignupState.loading(isFacebookSignIn: true));

      final user = await signupUseCase.signInWithFacebook();

      emit(state.copyWith(status: BaseState.success(), user: user));
    } catch (e) {
      emit(
        SignupState.error(errorMessage: AppExceptionHandler.handleException(e)),
      );
    }
  }
}

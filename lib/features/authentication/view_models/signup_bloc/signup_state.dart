import 'package:equatable/equatable.dart';

import '../../../../core/basestate.dart';
import '../../../profile/data/models/user_model.dart';

class SignupState implements Equatable {
  final BaseState status;
  final bool isGoogleSignIn;
  final bool isFacebookSignIn;
  final UserModel? user;

  SignupState({
    this.status = const BaseState(),
    this.user,
    this.isGoogleSignIn = false,
    this.isFacebookSignIn = false,
  });

  SignupState copyWith({
    BaseState? status,
    UserModel? user,
    bool? isGoogleSignIn,
    bool? isFacebookSignIn,
  }) {
    return SignupState(
      status: status ?? this.status,
      user: user ?? this.user,
      isGoogleSignIn: isGoogleSignIn ?? this.isGoogleSignIn,
      isFacebookSignIn: isFacebookSignIn ?? this.isFacebookSignIn,
    );
  }

  factory SignupState.loading({bool? isGoogleSignIn, bool? isFacebookSignIn}) =>
      SignupState(
        status: BaseState.loading(),
        isGoogleSignIn: isGoogleSignIn ?? false,
        isFacebookSignIn: isFacebookSignIn ?? false,
      );
  factory SignupState.success({String? successMessage}) =>
      SignupState(status: BaseState.success(successMessage: successMessage));
  factory SignupState.error({String? errorMessage}) =>
      SignupState(status: BaseState.error(errorMessage: errorMessage));

  @override
  List<Object?> get props => [status, user];

  @override
  String toString() {
    return 'SignupState(status: ${status.toString()}, user: ${user.toString()})';
  }

  @override
  bool? get stringify => true;
}

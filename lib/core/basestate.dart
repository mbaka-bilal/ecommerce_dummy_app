import 'package:equatable/equatable.dart';

import 'enums.dart';

class BaseState extends Equatable {
  const BaseState({
    this.status = Status.initial,
    this.errorMessage,
    this.successMessage,
  });

  final Status status;
  final String? errorMessage;
  final String? successMessage;

  factory BaseState.initial() => const BaseState();
  factory BaseState.loading() => const BaseState(status: Status.loading);
  factory BaseState.success({String? successMessage}) =>
      BaseState(status: Status.success, successMessage: successMessage);
  factory BaseState.error({String? errorMessage}) =>
      BaseState(status: Status.error, errorMessage: errorMessage);

  @override
  List<Object?> get props => [status, errorMessage, successMessage];

  @override
  String toString() {
    return 'BaseState(status: ${status.name}, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool? get stringify => true;
}

import 'package:equatable/equatable.dart';

class LoginFormModel extends Equatable {
  final bool? enableButton;

  const LoginFormModel({this.enableButton});

  @override
  List<Object?> get props => [enableButton];
}

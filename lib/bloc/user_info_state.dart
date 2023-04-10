import 'package:equatable/equatable.dart';

import '../models/user_model.dart';

class UserInfoState extends Equatable {
  const UserInfoState._({required this.user});

  const UserInfoState.unKnown() : this._(user: const User("", "", "",""));

  const UserInfoState.newInfo(User userInfo) : this._(user: userInfo);

  final User user;

  @override
  List<Object?> get props => [user];
}

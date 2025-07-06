import 'package:equatable/equatable.dart';

import '../features/profile/data/models/user_model.dart';

class UserInfoState extends Equatable {
  const UserInfoState._({required this.user});

  const UserInfoState.unKnown()
    : this._(
        user: const UserModel(firstName: "", lastName: "", email: "", uid: ""),
      );

  const UserInfoState.newInfo(UserModel userInfo) : this._(user: userInfo);

  final UserModel user;

  @override
  List<Object?> get props => [user];
}

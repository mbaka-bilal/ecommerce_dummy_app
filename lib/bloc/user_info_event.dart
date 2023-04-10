import 'package:ecommerce_dummy_app/models/user_model.dart';

abstract class UserInfoEvent{
  const UserInfoEvent();
}

class UserInfoChanged extends UserInfoEvent{
  const UserInfoChanged(this.user);

  final User user;
}


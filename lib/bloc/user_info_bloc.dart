import 'dart:async';

import 'package:ecommerce_dummy_app/bloc/user_info_event.dart';
import 'package:ecommerce_dummy_app/bloc/user_info_state.dart';
import 'package:ecommerce_dummy_app/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';

import '../features/profile/data/models/user_model.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(const UserInfoState.unKnown()) {
    on<UserInfoChanged>(_onUserInfoChanged);
    _streamSubscription = _userRepository.status.listen((event) {
      add(UserInfoChanged(event));
    });
  }

  Future<void> _onUserInfoChanged(
    UserInfoChanged event,
    Emitter<UserInfoState> state,
  ) async {
    emit(
      UserInfoState.newInfo(
        UserModel(
          firstName: event.user.firstName,
          lastName: event.user.lastName,
          email: event.user.email,
          uid: event.user.uid,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  final UserRepository _userRepository;
  late StreamSubscription<UserModel> _streamSubscription;
}

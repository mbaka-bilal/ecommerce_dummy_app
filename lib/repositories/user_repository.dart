import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dummy_app/bloc/user_info_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../features/profile/data/models/user_model.dart';

class UserRepository {
  UserModel? _user;
  final _fAuth = auth.FirebaseAuth.instance;
  final _controller = StreamController<UserModel>();
  final _fDatabase = FirebaseFirestore.instance;
  StreamSubscription? _userInfoSubscription;

  Stream<UserModel> get status async* {
    yield (UserModel(firstName: "", lastName: "", email: "", uid: ""));
    yield* _controller.stream;
  }

  Future<void> fetchUser() async {
    // print("attempting to fetch user");
    if (_user != null) {
      // print("user exists");
      _controller.add(_user!);
    } else {
      // print("user does not exists fetching new user");

      try {
        _userInfoSubscription = _fDatabase
            .collection("users")
            .doc(_fAuth.currentUser!.uid)
            .snapshots()
            .listen((event) {
              Map<String, dynamic> userInfo = event.data()!;
              // print("the user data is $userInfo");
              _user = UserModel(
                firstName: userInfo["first_name"],
                lastName: userInfo["last_name"],
                email: _fAuth.currentUser!.email!,
                uid: _fAuth.currentUser!.uid,
              );
              _controller.add(
                UserModel(
                  firstName: userInfo["first_name"],
                  lastName: userInfo["last_name"],
                  email: _fAuth.currentUser!.email!,
                  uid: _fAuth.currentUser!.uid,
                ),
              );
            });
      } catch (e) {
        // print("errro fetching user info");
        _controller.add(
          UserModel(
            firstName: "Jhon",
            lastName: "Doe",
            email: _fAuth.currentUser!.email!,
            uid: _fAuth.currentUser!.uid,
          ),
        );
      }
    }
  }

  void dispose() {
    _controller.close();
    if (_userInfoSubscription != null) {
      _userInfoSubscription!.cancel();
    }
  }
}

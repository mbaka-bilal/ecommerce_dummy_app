import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dummy_app/bloc/user_info_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user_model.dart';

class UserRepository {
  User? _user;
  final _fAuth = auth.FirebaseAuth.instance;
  final _controller = StreamController<User>();
  final _fDatabase = FirebaseFirestore.instance;
  StreamSubscription? _userInfoSubscription;

  Stream<User> get status async* {
    yield (User("", "", "", ""));
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
          _user = User(userInfo["first_name"], userInfo["last_name"],
              _fAuth.currentUser!.email!, _fAuth.currentUser!.uid);
          _controller.add(User(userInfo["first_name"], userInfo["last_name"],
              _fAuth.currentUser!.email!, _fAuth.currentUser!.uid));
        });
      } catch (e) {
        // print("errro fetching user info");
        _controller.add(User("Jhon", "Doe", _fAuth.currentUser!.email!,
            _fAuth.currentUser!.uid));
      }
    }
  }

  void dispose() {
    _controller.close();
    if (_userInfoSubscription != null){
      _userInfoSubscription!.cancel();
    }
  }
}

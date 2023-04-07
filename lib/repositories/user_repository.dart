import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user_model.dart';

class UserRepository {
  User? _user;
  final _fAuth = auth.FirebaseAuth.instance;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    return Future.delayed(const Duration(milliseconds: 300), () async {
      return User(_fAuth.currentUser!.uid); //
    });
  }
}

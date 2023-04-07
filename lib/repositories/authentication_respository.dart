import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/authentication_model.dart';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationModel>();
  final _fAuth = FirebaseAuth.instance;

  Stream<AuthenticationModel> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationModel(
        authenticationStatus: AuthenticationStatus.unKnown);
    yield* _controller.stream;
  }

  Future<void> signUpEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _controller.add(AuthenticationModel(
        authenticationStatus: AuthenticationStatus.signingUpInProgress));
    try {
      print("tring to sign up");

      await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await Future.delayed(
          const Duration(milliseconds: 300),
              () => _controller.add(AuthenticationModel(
              authenticationStatus: AuthenticationStatus.signUpSuccessfully,
              statusMessage: "Account created, Welcome!!")));

    } on FirebaseAuthException catch (e) {
      print("Error signin up $e");
      switch (e.code) {
        case 'email-already-in-use':
          await Future.delayed(
              const Duration(milliseconds: 300),
              () => _controller.add(AuthenticationModel(
                  authenticationStatus: AuthenticationStatus.signUpError,
                  statusMessage: "Email taken")));
          break;
        case 'network-request-failed':
          await Future.delayed(
              const Duration(milliseconds: 300),
              () => _controller.add(AuthenticationModel(
                  authenticationStatus: AuthenticationStatus.signUpError,
                  statusMessage: "No internet connection")));
          break;
        default:
          await Future.delayed(
              const Duration(milliseconds: 300),
              () => _controller.add(AuthenticationModel(
                  authenticationStatus: AuthenticationStatus.signUpError,
                  statusMessage: "Unknown error")));
          break;
      }
    } catch (e) {
      print("uncaught error $e");
      await Future.delayed(
          const Duration(milliseconds: 300),
          () => _controller.add(AuthenticationModel(
              authenticationStatus: AuthenticationStatus.signUpError,
              statusMessage: "Unknown error")));
    }
  }

  void dispose() => _controller.close();
}

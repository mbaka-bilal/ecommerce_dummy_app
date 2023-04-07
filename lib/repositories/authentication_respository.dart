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

  Future<void> signInEmailAndPassword(
      {required String email, required String password}) async {
    _controller.add(AuthenticationModel(
        authenticationStatus: AuthenticationStatus.loginInProgress,
        statusMessage: "Gaining access..."));
    try {
      await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      await Future.delayed(
          Duration(milliseconds: 300),
          () => _controller.add(AuthenticationModel(
              authenticationStatus: AuthenticationStatus.loginSuccessfully,
              statusMessage: "Access granted, \n Don't shop responsibly")));
    } on FirebaseAuthException catch (e) {
      print("caught sign in Error signin in $e");
      // await Future.delayed(Duration(milliseconds: 300), () {
      //   _controller.add(AuthenticationModel(
      //       authenticationStatus: AuthenticationStatus.loginError,
      //       statusMessage: "Unknown Error"));
      // });
      switch (e.code){
        case 'network-request-failed':
          await Future.delayed(
              const Duration(milliseconds: 300),
                  () => _controller.add(AuthenticationModel(
                  authenticationStatus: AuthenticationStatus.loginError,
                  statusMessage: "No internet connection")));
          break;
        case 'user-not-found':
          await Future.delayed(
              const Duration(milliseconds: 300),
                  () => _controller.add(AuthenticationModel(
                  authenticationStatus: AuthenticationStatus.loginError,
                  statusMessage: "Incorrect username/password")));
          break;
        default:
          await Future.delayed(
              const Duration(milliseconds: 300),
                  () => _controller.add(AuthenticationModel(
                  authenticationStatus: AuthenticationStatus.loginError,
                  statusMessage: "Unknown error")));
          break;
      }
    } catch (e) {
      print("Uncaught sign in error $e");
      await Future.delayed(Duration(milliseconds: 300), () {
        _controller.add(AuthenticationModel(
            authenticationStatus: AuthenticationStatus.loginError,
            statusMessage: "Unknown Error"));
      });
    }
  }

  Future<void> signUpEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _controller.add(AuthenticationModel(
        authenticationStatus: AuthenticationStatus.signingUpInProgress,
    statusMessage: "Creating your account....",
    ));
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

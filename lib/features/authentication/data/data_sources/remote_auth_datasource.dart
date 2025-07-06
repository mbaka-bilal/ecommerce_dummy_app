import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/exception_handlers/exception_types.dart';
import '../../../../core/exception_handlers/firebase_exception_handler.dart';

class RemoteAuthDataSource {
  final _fAuth = FirebaseAuth.instance;

  Future<String> signInEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _fAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user!.emailVerified == false) {
        throw UserNotVerifiedException(AppStrings.emailNotVerified);
      }

      return user.user!.uid;
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<String> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final user = await _fAuth.signInWithCredential(credential);

      if (_fAuth.currentUser!.emailVerified == false) {
        throw UserNotVerifiedException(AppStrings.emailNotVerified);
      }

      return user.user!.uid;
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<String> signInWithFacebook() async {
    try {
      //TODO implement signin with facebook
      throw UnimplementedError();
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<String> signUpEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final user = await _fAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user.user!.sendEmailVerification();

      return user.user!.uid;
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<void> sendUserConfirmationLinkToEmail() async {
    try {
      if (_fAuth.currentUser == null) {
        throw NoUserLoggedInException();
      }

      await _fAuth.currentUser!.sendEmailVerification();

      return;
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _fAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<void> logOut() async {
    try {
      await _fAuth.signOut();
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<bool> isUserLoggedIn() async {
    try {
      return _fAuth.currentUser != null;
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }
}

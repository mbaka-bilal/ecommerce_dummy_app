import 'package:firebase_auth/firebase_auth.dart';

import '../constants/strings.dart';
import 'exception_types.dart';

class FirebaseExceptionHandler {
  static Exception handleException(Object e) {
    if (e is FirebaseAuthException) {
      return handleAuthException(e);
    } else if (e is FirebaseException) {
      return handleFirebaseException(e);
    }

    return throw e;
  }

  static AuthException handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'network-request-failed':
        return AuthException(AppStrings.noInternetConnection);
      case 'user-not-found':
        return AuthException(AppStrings.incorrectUsernamePassword);
      case 'wrong-password':
        return AuthException(AppStrings.incorrectUsernamePassword);
      case 'email-already-in-use':
        return AuthException(AppStrings.emailTaken);
      case 'invalid-email':
        return AuthException(AppStrings.invalidEmail);
      default:
        return AuthException(AppStrings.unknownError);
    }
  }

  static FirebaseError handleFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'network-request-failed':
        return FirebaseError(AppStrings.noInternetConnection);
      default:
        return FirebaseError(AppStrings.unknownError);
    }
  }
}

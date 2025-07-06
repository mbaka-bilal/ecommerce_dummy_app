import '../constants/strings.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class UserNotVerifiedException implements Exception {
  final String message;

  UserNotVerifiedException(this.message);
}

class FirebaseError implements Exception {
  final String message;

  FirebaseError(this.message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

class GoogleSignInAbortedException implements Exception {
  GoogleSignInAbortedException();
}

class NoUserLoggedInException implements Exception {
  final String message;

  NoUserLoggedInException({this.message = AppStrings.noUserLoggedIn});
}

class AppException implements Exception {
  final String? message;

  AppException({this.message = AppStrings.unknownError});
}

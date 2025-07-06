import '../../data/data_sources/remote_auth_datasource.dart';

import 'signup_repository.dart';

class ISignupRepository implements SignupRepository {
  final RemoteAuthDataSource remoteAuthDataSource = RemoteAuthDataSource();

  @override
  Future<void> sendUserConfirmationLinkToEmail() async {
    try {
      await remoteAuthDataSource.sendUserConfirmationLinkToEmail();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signUpEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      return await remoteAuthDataSource.signUpEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      return await remoteAuthDataSource.isUserLoggedIn();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await remoteAuthDataSource.logOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await remoteAuthDataSource.resetPassword(email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signInEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await remoteAuthDataSource.signInEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signInWithFacebook() async {
    try {
      return await remoteAuthDataSource.signInWithFacebook();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> signInWithGoogle() async {
    try {
      return await remoteAuthDataSource.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }
}

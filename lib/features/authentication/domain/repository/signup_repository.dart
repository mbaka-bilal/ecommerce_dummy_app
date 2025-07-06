abstract class SignupRepository {
  Future<String> signInEmailAndPassword({
    required String email,
    required String password,
  });

  Future<String> signInWithGoogle();

  Future<String> signInWithFacebook();

  Future<String> signUpEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  Future<void> sendUserConfirmationLinkToEmail();

  Future<void> resetPassword(String email);

  Future<void> logOut();

  Future<bool> isUserLoggedIn();
}

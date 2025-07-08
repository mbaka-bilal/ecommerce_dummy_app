import 'dart:async';

import 'package:ecommerce_dummy_app/repositories/database_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/authentication_model.dart';
// import '../models/user_model.dart' as user_model;

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationModel>();
  final _fAuth = FirebaseAuth.instance;
  final _databaseRepository = DatabaseRepository();

  Stream<AuthenticationModel> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationModel(
      authenticationStatus: AuthenticationStatus.unKnown,
    );
    yield* _controller.stream;
  }

  // Future<User?> _tryGetUser() async {
  //   try {
  //     final user = await _userRepository.getUser();
  //     return user;
  //   } catch (_) {
  //     return null;
  //   }
  // }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth!.idToken,
      );
      //
      await FirebaseAuth.instance.signInWithCredential(credential);
      Future.delayed(Duration(milliseconds: 300), () {
        _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.loginSuccessfully,
            statusMessage: "Access granted, \n Don't shop responsibly",
          ),
        );
      });
    } catch (e) {
      // print("could not login with google $e");
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.loginError,
            statusMessage: "Unknown error",
          ),
        ),
      );
    }
  }

  Future<void> signInEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _controller.add(
      AuthenticationModel(
        authenticationStatus: AuthenticationStatus.loginInProgress,
        statusMessage: "Gaining access...",
      ),
    );
    try {
      final user = await _fAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user!.emailVerified) {
        await Future.delayed(
          const Duration(milliseconds: 300),
          () => _controller.add(
            AuthenticationModel(
              authenticationStatus: AuthenticationStatus.loginSuccessfully,
              statusMessage: "Access granted, \n Don't shop responsibly",
            ),
          ),
        );
      } else {
        await Future.delayed(
          const Duration(milliseconds: 300),
          () => _controller.add(
            AuthenticationModel(
              authenticationStatus: AuthenticationStatus.emailNotVerified,
              statusMessage: "Email not verified, please verify your email",
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // print("caught sign in Error signin in $e");
      switch (e.code) {
        case 'network-request-failed':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus: AuthenticationStatus.loginError,
                statusMessage: "No internet connection",
              ),
            ),
          );
          break;
        case 'user-not-found':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus: AuthenticationStatus.loginError,
                statusMessage: "Incorrect username/password",
              ),
            ),
          );
          break;
        case 'wrong-password':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus: AuthenticationStatus.loginError,
                statusMessage: "Incorrect username/password",
              ),
            ),
          );
          break;
        default:
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus: AuthenticationStatus.loginError,
                statusMessage: "Unknown error",
              ),
            ),
          );
          break;
      }
    } catch (e) {
      // print("Uncaught sign in error $e");
      await Future.delayed(const Duration(milliseconds: 300), () {
        _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.loginError,
            statusMessage: "Unknown Error",
          ),
        );
      });
    }
  }

  Future<void> signUpEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    _controller.add(
      AuthenticationModel(
        authenticationStatus: AuthenticationStatus.signingUpInProgress,
        statusMessage: "Creating your account....",
      ),
    );
    try {
      // print("tring to sign up");

      await _fAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _databaseRepository.createUser(firstName, lastName);
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.signUpSuccessfully,
            statusMessage: "Account created, Welcome!!",
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // print("Error signin up $e");
      switch (e.code) {
        case 'email-already-in-use':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus: AuthenticationStatus.signUpError,
                statusMessage: "Email taken",
              ),
            ),
          );
          break;
        case 'network-request-failed':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus: AuthenticationStatus.signUpError,
                statusMessage: "No internet connection",
              ),
            ),
          );
          break;
        default:
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus: AuthenticationStatus.signUpError,
                statusMessage: "Unknown error",
              ),
            ),
          );
          break;
      }
    } catch (e) {
      // print("uncaught error $e");
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.signUpError,
            statusMessage: "Unknown error",
          ),
        ),
      );
    }
  }

  Future<void> sendUserConfirmationLinkToEmail(User user) async {
    try {
      // print("sending confirmation link");
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus:
                AuthenticationStatus.sendingUserConfirmationLink,
            statusMessage: "Sending Link to email...",
          ),
        ),
      );
      await user.sendEmailVerification();
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.userConfirmationLinkSent,
            statusMessage: "Success",
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // print("error sending the link to email $e");
      switch (e.code) {
        case 'too-many-requests':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus:
                    AuthenticationStatus.errorSendingUserConfirmationLink,
                statusMessage: "Too many requests, try again later",
              ),
            ),
          );
          break;
        case 'network-request-failed':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus:
                    AuthenticationStatus.errorSendingUserConfirmationLink,
                statusMessage: "No internet connection",
              ),
            ),
          );
          break;
        default:
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus:
                    AuthenticationStatus.errorSendingUserConfirmationLink,
                statusMessage: "Unknown error",
              ),
            ),
          );
          break;
      }
    } catch (e) {
      // print("error sending the link to email $e");
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus:
                AuthenticationStatus.errorSendingUserConfirmationLink,
            statusMessage: "Unknown error",
          ),
        ),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      // print("begin resetting password");
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus:
                AuthenticationStatus.resettingPasswordInProgress,
            statusMessage: "resetting password...",
          ),
        ),
      );
      await _fAuth.sendPasswordResetEmail(email: email.trim());
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus:
                AuthenticationStatus.resettingPasswordSuccessfully,
            statusMessage: "Success",
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // print("error resetting password $e");
      switch (e.code) {
        case 'too-many-requests':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus:
                    AuthenticationStatus.resettingPasswordError,
                statusMessage: "Too many requests, try again later",
              ),
            ),
          );
          break;
        case 'network-request-failed':
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus:
                    AuthenticationStatus.resettingPasswordError,
                statusMessage: "No internet connection",
              ),
            ),
          );
          break;
        default:
          await Future.delayed(
            const Duration(milliseconds: 300),
            () => _controller.add(
              AuthenticationModel(
                authenticationStatus:
                    AuthenticationStatus.resettingPasswordError,
                statusMessage: "Unknown error",
              ),
            ),
          );
          break;
      }
    } catch (e) {
      // print("uncaught error when reseting password $e");
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.resettingPasswordError,
            statusMessage: "Unknown error",
          ),
        ),
      );
    }
  }

  Future<void> logOut() async {
    try {
      // print("logging out the user");
      await _fAuth.signOut();
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.unauthenticated,
          ),
        ),
      );
    } catch (e) {
      // print("unable to sign out user $e");
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.unKnown,
          ),
        ),
      );
    }
  }

  Future<void> tryGetUser() async {
    try {
      // print("checking if user is authenticated");
      final User? user = _fAuth.currentUser;
      if (user == null) {
        // print ("not user exists");
        await Future.delayed(
          const Duration(milliseconds: 300),
          () => _controller.add(
            AuthenticationModel(
              authenticationStatus: AuthenticationStatus.unauthenticated,
              statusMessage: "",
            ),
          ),
        );
      } else {
        // print ("user exists");
        await Future.delayed(
          const Duration(milliseconds: 300),
          () => _controller.add(
            AuthenticationModel(
              authenticationStatus: AuthenticationStatus.authenticated,
            ),
          ),
        );
      }
    } catch (e) {
      // print("checking if user is authenticated error $e");
      await Future.delayed(
        const Duration(milliseconds: 300),
        () => _controller.add(
          AuthenticationModel(
            authenticationStatus: AuthenticationStatus.unauthenticated,
          ),
        ),
      );
    }
  }

  void dispose() => _controller.close();
}

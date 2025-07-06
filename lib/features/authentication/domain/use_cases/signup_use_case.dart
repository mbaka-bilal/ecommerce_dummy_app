import '../../../profile/data/models/user_model.dart';
import '../../../profile/domain/entities/user_dto.dart';
import '../../../profile/domain/repositories/profile_repository.dart';
import '../repository/signup_repository.dart';

class SignupUseCase {
  final SignupRepository signupRepository;
  final ProfileRepository profileRepository;

  SignupUseCase({
    required this.signupRepository,
    required this.profileRepository,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userId = await signupRepository.signInEmailAndPassword(
        email: email,
        password: password,
      );

      return await profileRepository.getUser(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final userId = await signupRepository.signInWithGoogle();
      return await profileRepository.getUser(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signInWithFacebook() async {
    try {
      final userId = await signupRepository.signInWithFacebook();
      return await profileRepository.getUser(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final userId = await signupRepository.signUpEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      return await profileRepository.createUser(
        UserDto(
          uid: userId,
          email: email,
          firstName: firstName,
          lastName: lastName,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendUserConfirmationLinkToEmail() async {
    try {
      await signupRepository.sendUserConfirmationLinkToEmail();
    } catch (e) {
      rethrow;
    }
  }

}

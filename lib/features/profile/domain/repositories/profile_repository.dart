import '../../data/models/user_model.dart';
import '../entities/user_dto.dart';

abstract class ProfileRepository {
  Future<UserModel> createUser(UserDto user);
  Future<UserModel> getUser(String uid);
  Future<void> updateUser(UserDto user);
  Future<void> deleteAccount(String uid);
}

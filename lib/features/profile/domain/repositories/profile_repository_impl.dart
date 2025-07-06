import '../../data/data_sources/profile_remote_data_source.dart';
import '../../data/models/user_model.dart';
import '../entities/user_dto.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource =
      ProfileRemoteDataSource();

  @override
  Future<UserModel> createUser(UserDto user) async {
    try {
      return await profileRemoteDataSource.createUser(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser(String uid) async {
    try {
      return await profileRemoteDataSource.getUser(uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUser(UserDto user) async {
    try {
      await profileRemoteDataSource.updateUser(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount(String uid) async {
    try {
      await profileRemoteDataSource.deleteAccount(uid);
    } catch (e) {
      rethrow;
    }
  }
}

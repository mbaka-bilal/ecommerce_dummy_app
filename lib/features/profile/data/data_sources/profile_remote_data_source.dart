import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dummy_app/core/extensions/date_time_extension.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/exception_handlers/firebase_exception_handler.dart';
import '../../domain/entities/user_dto.dart';
import '../models/user_model.dart';

class ProfileRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> createUser(UserDto user) async {
    try {
      if (!user.validSignupData()) {
        throw Exception(AppStrings.unknownError);
      }

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set(user.toJson());

      return UserModel(
        firstName: user.firstName!,
        lastName: user.lastName!,
        email: user.email!,
        uid: user.uid!,
        createdAt: user.createdAt,
        updatedAt: user.createdAt,
      );
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      final user = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .get();
      return UserModel.fromJson(user.data()!);
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<void> updateUser(UserDto user) async {
    try {
      if (!user.hasUserId()) {
        throw Exception(AppStrings.userIDRequired);
      }

      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .update(user.toJson());
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }

  Future<void> deleteAccount(String uid) async {
    try {
      await _firestore.collection(AppConstants.usersCollection).doc(uid).update(
        {"deletedAt": DateTime.now().toTimestamp()},
      );
    } catch (e) {
      throw FirebaseExceptionHandler.handleException(e);
    }
  }
}

import 'package:ecommerce_dummy_app/core/extensions/date_time_extension.dart';
import 'package:ecommerce_dummy_app/core/extensions/string_extension.dart';

class UserDto {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? uid;
  final DateTime? createdAt;

  UserDto({
    this.firstName,
    this.lastName,
    this.email,
    this.uid,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) 'firstName': firstName!.firstLetterCapitalized(),
      if (lastName != null) 'lastName': lastName!.firstLetterCapitalized(),
      if (email != null) 'email': email,
      if (uid != null) 'uid': uid,
      if (createdAt != null) 'createdAt': createdAt!.toTimestamp(),
      'updatedAt': DateTime.now().toTimestamp(),
    };
  }

  bool validSignupData() {
    if (firstName == null ||
        lastName == null ||
        email == null ||
        uid == null ||
        createdAt == null) {
      return false;
    }
    return true;
  }

  bool hasUserId() {
    return uid != null;
  }
}

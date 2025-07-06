import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String uid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      uid: json['uid'],
      createdAt: json['createdAt']?.toDate(),
      updatedAt: json['updatedAt']?.toDate(),
      deletedAt: json['deletedAt']?.toDate(),
    );
  }

  @override
  List<Object> get props => [firstName, lastName, email, uid];

  bool get isDeleted => deletedAt != null;
}

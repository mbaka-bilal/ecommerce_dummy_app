
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.firstName, this.lastName, this.email,this.uid);

  final String firstName;
  final String lastName;
  final String email;
  final String uid;


  @override
  List<Object> get props => [firstName,lastName,email,uid];

  static const empty = User("", "", "","");
}
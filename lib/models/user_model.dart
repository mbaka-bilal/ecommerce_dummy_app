import 'package:equatable/equatable.dart';
// import 'package:'

class User extends Equatable {
  const User(this.id);

  final  id;

  @override
  List<Object> get props => [id];

  static const empty = User('-');
}
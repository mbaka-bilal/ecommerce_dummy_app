import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class LastProduct extends Equatable {
  LastProduct({required this.documentSnapshot});

  // {required this.documentSnapShot}

  final DocumentSnapshot documentSnapshot;

  @override
  // TODO: implement props
  List<Object?> get props => [documentSnapshot];
}


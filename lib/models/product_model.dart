import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductModel extends Equatable {
  const ProductModel(
      {this.rating = 0.0,
      this.description,
      this.amount = 0,
      required this.title,
      required this.documentID,
      required this.imageUrl,
      this.category,
      required this.documentSnapshot});

  final String? title;
  final String? category;
  final String? description;
  final String documentID;
  final String imageUrl;
  final dynamic rating;
  final int? amount;
  final DocumentSnapshot? documentSnapshot;

  @override
  List<Object?> get props => [
        title,
        imageUrl,
        rating,
        amount,
        documentSnapshot,
        documentID,
        category,
        description
      ];
}

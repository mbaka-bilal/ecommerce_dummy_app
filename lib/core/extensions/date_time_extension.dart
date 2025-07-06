import 'package:cloud_firestore/cloud_firestore.dart';

extension DateTimeExtension on DateTime {
  Timestamp toTimestamp() {
    return Timestamp.fromDate(this);
  }

  DateTime fromTimestamp(Timestamp timestamp) {
    return timestamp.toDate();
  }
}

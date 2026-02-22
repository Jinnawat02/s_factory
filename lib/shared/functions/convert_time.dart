import 'package:firebase_data_connect/firebase_data_connect.dart';

/// This lets you turn an ISO String directly into the GQL Object
Timestamp isoToGql(String isoString) {
  DateTime dt = DateTime.parse(isoString).toUtc();

  int seconds = dt.millisecondsSinceEpoch ~/ 1000;
  int nanos = (dt.microsecondsSinceEpoch % 1000000) * 1000;

  return Timestamp(nanos, seconds);
}

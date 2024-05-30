import 'dart:developer';
import 'package:attendance_keeper/core/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AnalyticsRemoteDataSource {
  Future<List<String?>?> getLast7DaysWork();
}

class AnalyticsRemoteDataSourceImpl implements AnalyticsRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AnalyticsRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<List<String?>?> getLast7DaysWork() {
    final Set<String> last7Days = {};
    return firestore
        .collection(FirebasePaths.workingDetails(auth.currentUser?.uid))
        .orderBy('end_time', descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (final doc in value.docs) {
          final endTimeStamp = doc.data()['end_time'] as Timestamp;
          log(endTimeStamp.toString());
          final endTimeDate =
              DateTime.fromMillisecondsSinceEpoch(endTimeStamp.seconds * 1000);
          log(endTimeDate.toString());
          DateFormat dateFormat = DateFormat.yMMMMd('ar');
          String endTime = dateFormat.format(endTimeDate);
          log(endTime.toString());
          last7Days.add(endTime);
        }
        return last7Days.toList();
      } else {
        return null;
      }
    });
  }

  String convertDateFormat(String dateString) {
    final DateFormat inputFormat = DateFormat('MMM d yyyy');
    final DateFormat outputFormat = DateFormat('d MMMM yyyy', 'ar');
    final DateTime date = inputFormat.parse(dateString);
    return outputFormat.format(date);
  }
}
import 'package:attendance_keeper/core/errors/failure.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class WorkingDetailsRemoteDataSource {
  Future<Unit> startWork(NoParams noParams);
}

class WorkingDetailsRemoteDataSourceImpl
    implements WorkingDetailsRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  WorkingDetailsRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<Unit> startWork(NoParams noParams) {
    try {
      final dateTime = DateTime.now();
      firestore
          .collection("users/${auth.currentUser!.uid}/working_details")
          .doc(dateTime.toIso8601String().toString())
          .set({"start_time": Timestamp.fromDate(dateTime), "end_time": null});

      firestore.collection("users").doc(auth.currentUser!.uid).set({
        "is_working": true,
        "last_slot_id": dateTime.toIso8601String().toString(),
        "last_start_time": Timestamp.fromDate(dateTime),
      });
      return Future.value(unit);
    } catch (e) {
      throw ServerFailure();
    }
  }
}

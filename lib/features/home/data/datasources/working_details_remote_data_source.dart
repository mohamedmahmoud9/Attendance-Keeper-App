import 'package:attendance_keeper/core/constants/firebase_constants.dart';
import 'package:attendance_keeper/core/errors/exception.dart';
import 'package:attendance_keeper/core/usecases/usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class WorkingDetailsRemoteDataSource {
  Future<Unit> startWork(NoParams noParams);
  Future<Unit> endWork(NoParams noParams);
  Future<String?> lastSlotId();
}

class WorkingDetailsRemoteDataSourceImpl
    implements WorkingDetailsRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  WorkingDetailsRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<Unit> startWork(NoParams noParams) async {
    try {
      final String? lastSlotIdCheck = await lastSlotId();
      if (lastSlotIdCheck != null) {
        throw AlreadyWorkingException();
      }

      final dateTime = DateTime.now();

      firestore
          .collection(FirebasePaths.workingDetails(auth.currentUser?.uid))
          .doc(dateTime.toIso8601String().toString())
          .set({"start_time": Timestamp.fromDate(dateTime), "end_time": null});

      firestore
          .collection(FirebasePaths.users)
          .doc(auth.currentUser!.uid)
          .update({
        "last_slot_id": dateTime.toIso8601String().toString(),
        "last_start_time": Timestamp.fromDate(dateTime),
      });

      return Future.value(unit);
    } catch (e) {
      if (e is AlreadyWorkingException) {
        rethrow;
      }
      throw ServerException();
    }
  }

  @override
  Future<String?> lastSlotId() {
    return firestore
        .collection(FirebasePaths.users)
        .doc(auth.currentUser?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        return value.data()?['last_slot_id'];
      } else {
        return null;
      }
    });
  }

  @override
  Future<Unit> endWork(NoParams noParams) async {
    try {
      final String? lastSlotIdCheck = await lastSlotId();
      if (lastSlotIdCheck == null) {
        throw NotWorkingException();
      }

      final dateTime = DateTime.now();

      firestore
          .collection(FirebasePaths.workingDetails(auth.currentUser?.uid))
          .doc(lastSlotIdCheck)
          .update({"end_time": Timestamp.fromDate(dateTime)});

      firestore
          .collection(FirebasePaths.users)
          .doc(auth.currentUser!.uid)
          .update({
        "last_slot_id": null,
        "last_start_time": null,
      });

      return Future.value(unit);
    } catch (e) {
      if (e is NotWorkingException) {
        rethrow;
      }
      throw ServerException();
    }
  }
}

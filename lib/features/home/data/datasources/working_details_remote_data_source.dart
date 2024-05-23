import 'dart:developer';

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
  Future<int> getTotalWorkingHours(DateTime dateTime);
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

  @override
  Future<int> getTotalWorkingHours(DateTime dateTime) async {
    List<Slot> slots = await slotsStream(dateTime).first;
    log(slots.length.toString());

    int totalWorkingSeconds = slots.fold(0, (previousValue, element) {
      DateTime start = element.start.toDate();
      DateTime end = element.end?.toDate() ?? DateTime.now();
      Duration duration = end.difference(start);
      return previousValue + duration.inSeconds;
    });
    return totalWorkingSeconds;
  }

  Stream<List<Slot>> slotsStream(DateTime dateTime) => firestore
      .collection(FirebasePaths.workingDetails(auth.currentUser?.uid))
      .snapshots()
      .map((event) => event.docs.where((element) {
            DateTime docDateTime = DateTime.parse(element.id);
            log(docDateTime.toIso8601String());
            return (docDateTime.year == dateTime.year &&
                docDateTime.month == dateTime.month &&
                docDateTime.day == dateTime.day);
          }).map((e) {
            Slot slot =
                Slot(start: e.data()['start_time'], end: e.data()['end_time']);

            return slot;
          }).toList());
}

class Slot {
  final Timestamp start;
  final Timestamp? end;
  Slot({required this.start, required this.end});
}

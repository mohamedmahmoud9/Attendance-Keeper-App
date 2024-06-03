import 'dart:developer';

import 'package:attendance_keeper/core/constants/firebase_constants.dart';
import 'package:attendance_keeper/core/errors/exception.dart';
import 'package:attendance_keeper/features/auth/data/models/user_model.dart';
import 'package:attendance_keeper/features/home/domain/repositories/working_details_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class WorkingDetailsRemoteDataSource {
  Future<Unit> startWork(String? uid);
  Future<Unit> endWork(EndWorkParams endWorkParams, String? uid);
  Future<String?> lastSlotId(String? uid);
  Future<int> getTotalWorkingHours(DateTime dateTime, String? uid);
  Future<UserModel> getUserData(String? uid);
}

class WorkingDetailsRemoteDataSourceImpl
    implements WorkingDetailsRemoteDataSource {
  final FirebaseFirestore firestore;

  WorkingDetailsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<Unit> startWork(String? uid) async {
    try {
      final String? lastSlotIdCheck = await lastSlotId(uid);
      if (lastSlotIdCheck != null) {
        throw AlreadyWorkingException();
      }
      final dateTime = DateTime.now();
      firestore
          .collection(FirebasePaths.workingDetails(uid))
          .doc(dateTime.toIso8601String().toString())
          .set({
        "start_time": Timestamp.fromDate(dateTime),
        "end_time": null,
        "tasks": []
      });
      firestore.collection(FirebasePaths.users).doc(uid).update({
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
  Future<Unit> endWork(EndWorkParams endWorkParams, String? uid) async {
    try {
      final String? lastSlotIdCheck = await lastSlotId(uid);
      if (lastSlotIdCheck == null) {
        throw NotWorkingException();
      }

      final dateTime = DateTime.now();
      firestore
          .collection(FirebasePaths.workingDetails(uid))
          .doc(lastSlotIdCheck)
          .update({
        "end_time": Timestamp.fromDate(dateTime),
        "tasks": endWorkParams.tasks
      });

      firestore.collection(FirebasePaths.users).doc(uid).update({
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
  Future<int> getTotalWorkingHours(DateTime dateTime, String? uid) async {
    List<Slot> slots = await slotsStream(dateTime, uid).first;
    log(slots.length.toString());
    int totalWorkingSeconds = slots.fold(0, (previousValue, element) {
      DateTime start = element.start.toDate();
      DateTime end = element.end?.toDate() ?? DateTime.now();
      Duration duration = end.difference(start);
      return previousValue + duration.inSeconds;
    });
    return totalWorkingSeconds;
  }

  Stream<List<Slot>> slotsStream(DateTime dateTime, String? uid) => firestore
      .collection(FirebasePaths.workingDetails(uid))
      .snapshots()
      .map((event) => event.docs.where((element) {
            DateTime docDateTime = DateTime.parse(element.id);
            log(docDateTime.toIso8601String());
            return (docDateTime.year == dateTime.year &&
                docDateTime.month == dateTime.month &&
                docDateTime.day == dateTime.day);
          }).map((e) {
            Slot slot = Slot.formJson(e.data());
            return slot;
          }).toList());

  @override
  Future<String?> lastSlotId(
    String? uid,
  ) {
    return firestore
        .collection(FirebasePaths.users)
        .doc(uid)
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
  Future<UserModel> getUserData(String? uid) async {
    final reponse =
        await firestore.collection(FirebasePaths.users).doc(uid).get();
    if (reponse.data() != null) {
      return UserModel.fromSnapshot(reponse.data()!);
    } else {
      throw ServerException();
    }
  }
}

class Slot {
  final Timestamp start;
  final Timestamp? end;
  final List<String> tasks;
  Slot({required this.start, required this.end, required this.tasks});
  factory Slot.formJson(Map<String, dynamic> json) {
    return Slot(
        start: json['start_time'],
        end: json['end_time'],
        tasks: List<String>.from(json['tasks']));
  }
}

import 'package:attendance_keeper/features/analytics/analytics_injection.dart';
import 'package:attendance_keeper/features/auth/auth_container.dart';
import 'package:attendance_keeper/features/home/home_injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Containers
  initAuth();
  initHome();
  initAnalytics();

  // Externals
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}

import 'package:attendance_keeper/app.dart';
import 'package:attendance_keeper/core/routers/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAUjGrJPBebgkfmYATJXHey1nxAQQb7ung',
      appId: '1:170760649242:android:27830394781eb6d8d5efa3',
      messagingSenderId: '170760649242',
      projectId: 'attendance-keeper-4fc13',
    ),
  );

  await EasyLocalization.ensureInitialized();
  await di.init();

  runApp(EasyLocalization(
    supportedLocales: const <Locale>[
      Locale('ar'),
    ],
    path: 'assets/languages',
    fallbackLocale: const Locale('ar'),
    startLocale: const Locale('ar'),
    child: TrueAttendanceKeeperApp(
      appRouter: AppRouter(),
    ),
  ));
}

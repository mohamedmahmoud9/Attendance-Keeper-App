import 'package:attendance_keeper/features/auth/presentation/pages/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'features/auth/injection_container.dart' as di;

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
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
      // initialRoute: '/',
      // routes: {
      //   Routes.signInScreen: (context) => const SignInScreen(),
      //   Routes.signUpScreen: (context) => const SignUpScreen(),
      // },
    );
  }
}

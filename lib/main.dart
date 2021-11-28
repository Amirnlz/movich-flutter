import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/starter/splash_screen.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF08161a),
        primaryColor: const Color(0xFF08161a),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

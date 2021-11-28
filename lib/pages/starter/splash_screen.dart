import 'package:flutter/material.dart';
import 'package:movich/pages/starter/login.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  const LoginPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: RiveAnimation.asset(
            'assets/splash_screen.riv',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

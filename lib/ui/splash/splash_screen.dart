import 'package:evently_c16_mon/firebase/firebase_auth_service.dart';
import 'package:evently_c16_mon/ui/home/home_screen.dart';
import 'package:evently_c16_mon/ui/setup/setup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      // var loggedIn = FirebaseAuthService().isLoggedIn();
      var loggedIn = false;
      var initialRoute = loggedIn? HomeScreen.routeName : SetupScreen.routeName;
      Navigator.pushReplacementNamed(context, initialRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/large_logo.png",
              width: MediaQuery.sizeOf(context).width * 0.4,
            ),
          ),
          Spacer(),
          SafeArea(
            bottom: true,
            child: Image.asset(
              "assets/images/branding.png",
              width: MediaQuery.sizeOf(context).width * 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

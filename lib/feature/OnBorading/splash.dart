import 'dart:async';
import 'package:event_app/core/prefs_manager/prefs_manager.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), _navigateNext);
  }

  void _navigateNext() {
    final seenOnboarding = PrefsManager.getBool('seenOnboarding');
    final user = FirebaseAuth.instance.currentUser;

    if (!seenOnboarding) {
      Navigator.pushReplacementNamed(context, RouteManager.onboarding);
    } else if (user == null) {
      Navigator.pushReplacementNamed(context, RouteManager.login);
    } else {
      Navigator.pushReplacementNamed(context, RouteManager.mainLayout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.eventLogo),
          ],
        ),
      ),
    );
  }
}

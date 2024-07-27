import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:des_uad/core/constant_finals.dart';
import 'package:des_uad/init_screens/fragment_view.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const FragmentPage(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
      splash: Center(
        child: Image.asset(
          imgUadLogo,
        ),
      ),
    );
  }
}
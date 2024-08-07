import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:des_uad/core/constant_finals.dart';
import 'package:des_uad/init_screens/fragment_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    cekKoneksi();
    super.initState();
  }

  cekKoneksi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 1), () {
      var token = pref.getString('token');
      print(token);
      if (token != '' && token != null) { 
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => FragmentPage()));
      } else { 
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
    // if (token != '') {
    //   Future.delayed(Duration(seconds: 1), () {
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => FragmentPage()));
    //   });
    // } else {
    //   Future.delayed(Duration(seconds: 1), () {
    //     Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (context) => LoginScreen()));
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const FragmentPage(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 70,
      splash: Center(
        child: Image.asset(
          imgUadLogo,
        ),
      ),
    );
  }
}

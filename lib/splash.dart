import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constant_finals.dart';
import 'cubit/home_cubit.dart';
import 'init_screens/fragment_view.dart';
import 'screens/login/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cekKoneksi();
  }

  void cekKoneksi() async {
    final cubit = context.read<HomeCubit>();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');

    if (token != '' && token != null) {
      cubit.getExceptionForHomepage();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _reload() async {
    setState(() {
      isLoading = true;
    });
    context.read<HomeCubit>().getExceptionForHomepage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        print(state);
        print(isLoading);
        if (state is StudentBodyLoading) {
          Future.delayed(const Duration(seconds: 5)).then((value) => {});
        } else if (state is StudentBodyLoaded) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const FragmentPage()),
          );
        } else if (state is StudentBodyEmpty || state is StudentBodyError) {
          Future.delayed(const Duration(seconds: 5)).then(
            (value) => {
              setState(() {
                isLoading = false;
              }),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state is StudentBodyEmpty
                      ? 'Data tidak tersedia.'
                      : (state as StudentBodyError).message),
                  backgroundColor: kBrickRed,
                ),
              ),
            },
          );
          // Tetap di splash screen jika data kosong atau error
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: kBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  imgUadLogo,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              isLoading
                  ? SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _reload, child: Text('Muat Ulang', style: Styles.kPublicMediumBodyTwo.copyWith(color: Colors.orange[900]),)),
            ],
          ),
        ),
      ),
    );
  }
}

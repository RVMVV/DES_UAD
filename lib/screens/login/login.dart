import 'package:des_uad/core/constant_finals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/login_cubit.dart';
import '../../init_screens/fragment_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  var _isFieldUsernamelValid = true;
  var _isFieldPasswordValid = true;
  bool passwordVisible = true;

  login() async {
    String username = _controllerUsername.text;
    String password = _controllerPassword.text;

    if (username == '' || password == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(milliseconds: 1500),
          content: Text(
            'Username & Password Harus Diisi',
          ),
        ),
      );
    } else {
      LoginCubit cubit = context.read<LoginCubit>();
      cubit..loginUser(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN IN',
            style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold)),
        centerTitle: false,
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        width: lebarLayar,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'UAD DES APP',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text('Username',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 2,
                  ),
                  Text('*',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              usernameField(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 2,
                  ),
                  Text('*',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              passwordField(),
              SizedBox(
                height: 30,
              ),
              tombol()
            ],
          ),
        ),
      ),
    );
  }

  Widget tombol() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.white))),
              backgroundColor: MaterialStateProperty.all(kBlue)),
          onPressed: () {
            login();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                print(state);

                if (state is LoginFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      duration: const Duration(milliseconds: 1500),
                      content: Text(
                        state.message,
                      ),
                    ),
                  );
                } else if (state is LoginSuccess) {
                  Future.delayed(Duration(milliseconds: 100), () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FragmentPage()));
                  });
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                } else if (state is LoginSuccess) {
                  return Text(
                    'LOGIN',
                    style: TextStyle(
                        color: kWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  );
                }
                return Text(
                  'LOGIN',
                  style: TextStyle(
                      color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
                );
              },
            ),
          )),
    );
  }

  Widget usernameField() {
    return TextFormField(
        controller: _controllerUsername,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return 'Text is empty';
          }
          return null;
        },
        decoration: InputDecoration(
          isDense: true,
          labelText: 'user@example.com',
          fillColor: Colors.white,
        ));
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: passwordVisible,
      controller: _controllerPassword,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Text is empty';
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Password',
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(
              () {
                passwordVisible = !passwordVisible;
              },
            );
          },
        ),
      ),
    );
  }
}

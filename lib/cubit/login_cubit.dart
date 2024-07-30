import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/datasources/data_sources.dart';
import 'package:meta/meta.dart';

import '../data/models/login/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.dataSource}) : super(LoginInitial());

  final DataSource dataSource;

  Future<void> loginUser(String username, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    emit(LoginLoading());
    var login = await dataSource.loginUser(username, password);

    if (login.statusCode == 200) {
      dynamic data = jsonDecode(login.body);
      LogIn log = LogIn.fromJson(data);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', log.data.accessToken);
      pref.setString('user_id', log.data.userId);
      pref.setString('useremail', log.data.userEmail);
      emit(LoginSuccess());
    } else {
      emit(LoginFailed('Login Gagal'));
    }
  }
}

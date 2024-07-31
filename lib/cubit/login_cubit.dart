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
    emit(LoginLoading());
    var login = await dataSource.loginUser(username, password);

    if (login.statusCode == 200) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      dynamic data = jsonDecode(login.body);
      String cookies = login.headers['set-cookie'] ?? '-';
      pref.setString('cookies', cookies);

      LogIn log = LogIn.fromJson(data);
      pref.setString('token', log.data.accessToken);
      pref.setString('user_id', log.data.userId);
      pref.setString('useremail', log.data.userEmail);

      emit(LoginSuccess());
    } else {
      emit(LoginFailed('Login Gagal'));
    }
  }
}

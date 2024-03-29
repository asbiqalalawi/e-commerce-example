import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_example/feature/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService _service;

  LoginBloc(this._service) : super(LoginInitial()) {
    on<LoginWithUsernameEvent>((event, emit) async {
      try {
        emit(LoginInitial());
        emit(LoginLoading());
        final token = await _service.login(event.username, event.password);
        debugPrint(token);
        final preferences = await SharedPreferences.getInstance();
        preferences.setString('token', token);
        emit(LoginSuccess());
      } on DioException catch (e) {
        emit(LoginError(error: e.message ?? ''));
      } catch (e) {
        emit(LoginError(error: e.toString()));
      }
    });
  }
}

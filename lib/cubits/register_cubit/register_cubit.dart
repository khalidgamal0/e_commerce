import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/helper/api.dart';
import 'package:shop_app/models/login_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);
  LoginModel? loginModel;

  void userRegister({
    required String? email,
    required String? password,
    required String? phone,
    required String? name,
  }) {
    emit(RegisterLoading());
    ApiHelper()
        .post(
            url: registerUrl,
            body: jsonEncode({
              'name': name,
              'email': email,
              'password': password,
              'phone': phone,
            }))
        .then((value) {
      loginModel = LoginModel.fromJson(value);
      emit(RegisterSuccess(loginModel!));
    }).catchError((error) {
      print(error);
      emit(RegisterFailure(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeRegisterPasswordVisibility());
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/helper/api.dart';
import 'package:shop_app/models/login_model.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static  LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);
   LoginModel ? loginModel;

  void userLogin({
    @required String? email,
    @required String? password,
  }) {
    emit(LoginLoading());
      ApiHelper().post(
          url: loginUrl,
          body:jsonEncode({"email": email, "password": password})).then((value){
        loginModel =LoginModel.fromJson(value);
        emit(LoginSuccess(loginModel!));
      }).catchError((error){
        print(error.toString());
        emit(LoginFailure(error.toString()));
      });

  }

  IconData suffix =Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined :  Icons.visibility_outlined;
    emit(ChangePasswordVisibility());
  }

}

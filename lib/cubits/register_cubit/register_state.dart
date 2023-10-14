part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {
  final LoginModel loginModel;
  RegisterSuccess(this.loginModel);
}
class RegisterFailure extends RegisterState {
  final String errorMessage;
  RegisterFailure(this.errorMessage);
}
class ChangeRegisterPasswordVisibility extends RegisterState {

}

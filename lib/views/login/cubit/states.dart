
import 'package:chat_app_socket_io/model/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates
{
  final SignUpModel signModel;

  LoginSuccessState(this.signModel);
}

class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}
class ChangePasswordVisibilityState extends LoginStates {}

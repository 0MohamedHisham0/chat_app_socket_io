
import 'package:chat_app_socket_io/model/user_model.dart';

abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates
{
  final SignUpModel signModel;

  SignUpSuccessState(this.signModel);
}

class SignUpErrorState extends SignUpStates
{
  final String error;

  SignUpErrorState(this.error);
}
class ChangePasswordVisibilityState extends SignUpStates {}

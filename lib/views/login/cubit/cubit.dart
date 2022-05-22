import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_socket_io/model/user_model.dart';
import 'package:chat_app_socket_io/views/login/cubit/states.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late SignUpModel signInModel;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void login({
    required String? email,
    required String? password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
      },
    ).then((value) {
      signInModel = SignUpModel.fromJson(value.data);

      if (signInModel.status == true) {
        print("true");
        emit(LoginSuccessState(signInModel));

        token = signInModel.token;
        userID = signInModel.user?.sId;

      } else {
        print("true");

        print(signInModel.message);
        emit(LoginErrorState(signInModel.message.toString()));
      }

      if (signInModel.status == false) {
        emit(LoginErrorState(signInModel.message.toString()));
      }

      if (value.statusCode == 400) {
        print("400");
        emit(LoginErrorState(signInModel.message.toString()));
      }
    }).catchError((error) {
      print(error);
      emit(LoginErrorState("Something went wrong"));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}

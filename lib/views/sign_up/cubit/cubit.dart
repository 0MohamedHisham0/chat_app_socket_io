import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_socket_io/model/user_model.dart';
import 'package:chat_app_socket_io/views/sign_up/cubit/states.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  late SignUpModel signInModel;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void signUp({
    required String? email,
    required String? name,
    required String? password,
  }) {
    emit(SignUpLoadingState());

    DioHelper.postData(
      url: SIGN_UP,
      data: {
        "name": name,
        "password": password,
        "password2": password,
        "email": email,
      },
    ).then((value) {
      SignUpModel signUpModel = SignUpModel.fromJson(value.data);

      if (signUpModel.status == true) {
        print("true");
        emit(SignUpSuccessState(signUpModel));

        token = signInModel.token;
        userID = signInModel.user?.sId;
      } else {
        print("true");

        print(signUpModel.message);
        emit(SignUpErrorState(signUpModel.message.toString()));
      }

      if (signUpModel.status == false) {
        emit(SignUpErrorState(signUpModel.message.toString()));
      }

      if (value.statusCode == 400) {
        print("400");
        emit(SignUpErrorState(signUpModel.message.toString()));
      }
    }).catchError((error) {
      print(error);
      emit(SignUpErrorState("Something went wrong"));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}

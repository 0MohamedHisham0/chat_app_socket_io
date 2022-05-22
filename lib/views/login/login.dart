import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_socket_io/views/friends/friends_screen.dart';
import 'package:chat_app_socket_io/views/sign_up/sign_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../widegets/bezierContainer.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();



    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'token',
              value: state.signModel.token,
            ).then((value) {
              token = state.signModel.token;
              userID = state.signModel.user!.sId;
              CacheHelper.saveData(key: "userID", value: userID)
                  .then((value) => {
                        navigateAndFinish(context, const FriendsScreen()),
                      });
            });
          }

          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          final height = MediaQuery.of(context).size.height;

          return Scaffold(
            body: SizedBox(
              height: height,
              child: Stack(
                children: [
                  SafeArea(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      color: mainColorMaterial,
                    ),
                  ),
                   Positioned(
                      top: -height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: const BezierContainer()),
                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: mainColorMaterial),
                                  ),
                                  Text(
                                    'Welcome back',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                      return 'Please enter valid email';
                                    }
                                    return null;
                                  },
                                  label: 'Email',
                                  prefix: Icons.email_outlined,
                                  onChange: (value) {}),
                              const SizedBox(
                                height: 15.0,
                              ),
                              defaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                suffix: cubit.suffix,
                                onSubmit: (value) {
                                  if (formKey.currentState!.validate()) {
                                    print(
                                        '${emailController.text} ====================');
                                    print(passwordController.text);
                                    cubit.login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                isPassword: cubit.isPassword,
                                suffixPressed: () {
                                  cubit.changePasswordVisibility();
                                  print("suffixPressed");
                                },
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                label: 'Password',
                                prefix: Icons.lock_outline,
                                onChange: (value) {},
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.login(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'Login',
                                  isUpperCase: true,
                                ),
                                fallback: (context) => progressLoading(),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account?',
                                  ),
                                  ButtonTheme(
                                    minWidth: 0,
                                    child: MaterialButton(
                                      onPressed: () {
                                        navigateTo(context, SignUpScreen());
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Color(mainColor),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_socket_io/views/friends/friends_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../widegets/bezierContainer.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
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

          if (state is SignUpErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          var cubit = SignUpCubit.get(context);

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
                              Text(
                                'Sign Up',
                                style:
                                    Theme.of(context).textTheme.headline4!.copyWith(
                                          color: Colors.black,
                                        ),
                              ),
                              Text(
                                'Welcome to Our Chat App',
                                style:
                                    Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: Colors.grey,
                                        ),
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
                                  controller: nameController,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                  label: 'Name',
                                  prefix: Icons.person_outline,
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
                                    cubit.signUp(
                                        email: emailController.text,
                                        name: nameController.text,
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
                                condition: state is! SignUpLoadingState,
                                builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.signUp(
                                          email: emailController.text,
                                          name: nameController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'Sign Up',
                                  isUpperCase: true,
                                ),
                                fallback: (context) => progressLoading(),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Already have an account?',
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

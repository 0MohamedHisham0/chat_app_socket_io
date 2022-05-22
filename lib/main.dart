import 'package:chat_app_socket_io/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app_socket_io/shared/bloc_observer.dart';
import 'package:chat_app_socket_io/shared/cubit/cubit.dart';
import 'package:chat_app_socket_io/shared/network/local/cache_helper.dart';
import 'package:chat_app_socket_io/shared/network/remote/dio_helper.dart';
import 'package:chat_app_socket_io/views/friends/friends_screen.dart';
import 'package:chat_app_socket_io/views/welcome_page/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  userID = CacheHelper.getData(key: 'userID');

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ChatAppCubit()
              ..getMyFriends()
              ..getAllFriends(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: mainColorMaterial,
          ),
          debugShowCheckedModeBanner: false,
          home: token == null ? WelcomePage() : const FriendsScreen(),
        ));
  }
}

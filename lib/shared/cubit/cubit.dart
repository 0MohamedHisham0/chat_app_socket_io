import 'package:chat_app_socket_io/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../model/all_friends_model.dart';
import '../../model/chat_model.dart';
import '../../model/get_chat_model.dart';
import '../../model/get_friends_model.dart';
import '../components/constants.dart';

class ChatAppCubit extends Cubit<ChatAppStates> {
  ChatAppCubit() : super(ChatAppInitialState());

  static ChatAppCubit get(context) => BlocProvider.of(context);
  var chat = <Chat>[];

  GetMyFriendsModel? getMyFriendsModel;
  GetAllFriendsModel? getAllFriendsModel;
  GetChatModel? getChatModel;

  void getMyFriends() {
    emit(ChatAppGetMyFriendsLoadingState());

    DioHelper.getData(url: GET_MY_FRINDES, token: token).then((value) {
      getMyFriendsModel = GetMyFriendsModel.fromJson(value.data);

      if (getMyFriendsModel?.status == true) {
        print(true);

        emit(ChatAppGetMyFriendsSuccessState());
      } else {
        print(getMyFriendsModel!.message);
        print(getMyFriendsModel!.friends?.length);

        emit(ChatAppGetMyFriendsSuccessState());
      }
    }).catchError((error) {
      print(error);
      emit(ChatAppGetMyFriendsErrorState('Something went wrong'));
    });
  }

  void getAllFriends() {
    emit(ChatAppGetAllUsersLoadingState());

    DioHelper.getData(url: GET_ALL_USERS).then((value) {
      getAllFriendsModel = GetAllFriendsModel.fromJson(value.data);


      if (getAllFriendsModel?.status == true) {
        print(true);
        emit(ChatAppGetAllUsersSuccessState());
      } else {
        print(getAllFriendsModel!.message);
        print(getAllFriendsModel!.users?.length);

        emit(ChatAppGetAllUsersSuccessState());
      }
    }).catchError((error) {
      print(error);
      emit(ChatAppGetAllUsersErrorState('Something went wrong'));
    });
  }

  void filteredFriendsList(List<FriendsGetMyFriendsModel> list) {

  }

  void startChat(friendID, friendName) {
    DioHelper.postData(data: {}, url: START_CHAT + friendID, token: token).then(
      (value) {
        showToast(
            text: "Now you can start chat with $friendName",
            state: ToastStates.SUCCESS);
      },
    ).catchError((error) {
      showToast(text: "Something went wrong", state: ToastStates.ERROR);
    });
  }

  //Chat

  late var socket;
  late var chats = <Chat>[];

  void sendMessage(String message, String chatID) {
    socket.emit(
        'sendMessage', Chat(chat: chatID, content: message, sender: userID));
    emit(ChatAppNewMessageState());
    print(message);
  }

  void connectAndListenBlocFun() {}

  void connectAndListen(String chatId) {
    socket = io.io(
        serverUrl,
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .build());

    socket.connect();
    print('connected');
    socket.on('connection', (_) {
      print('Connected to server');
      socket.emit('joinChat', chatId);
      socket.emit('GetMessages', {'MeId': userID, 'ChatId': chatId});
    });

    socket.on(
        'newMessage',
        (data) => {
              chats.add(Chat(
                  chat: chatId,
                  content: data['content'],
                  sender: data['sender'])),
              print(data),
              emit(ChatAppNewMessageState()),
            });

    //When an event received from server, data is added to the stream
    socket.on('sendMessage', (data) {
      print('Received message from server');
    });

    socket.on('joinChat', (data) {
      print("joined chat");
    });
  }

  void dispose() {
    socket.dispose();
    socket.destroy();
    socket.close();
    socket.disconnect();
  }

  Future<List<Chat>> getFriendChat(String chatID) async {
    DioHelper.getData(url: GET_CHAT_BY_ID + chatID, token: token).then((value) {
      getChatModel = GetChatModel.fromJson(value.data);
      getChatModel!.messages!.forEach((element) {
        var data = Chat(
          chat: chatID,
          content: element.content,
          sender: element.sender,
        );
        chats.add(data);
      });
      emit(ChatAppGetChatSuccessState());
      print(value.data);
    }).catchError((error) {
      print(error);
    });
    return chat;
  }
}

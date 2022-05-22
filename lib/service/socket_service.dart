import 'dart:async';
import 'package:chat_app_socket_io/shared/components/constants.dart';
import 'package:chat_app_socket_io/shared/network/remote/dio_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../model/chat_model.dart';
import '../model/get_chat_model.dart';


class SocketService {
  static late StreamController<Chat> socketResponse;
  static late StreamController<List<String>> _userResponse;
  static late io.Socket _socket;

  static String? get userId => _socket.id;

  static Stream<Chat> get getResponse =>
      socketResponse.stream.asBroadcastStream();

  static Stream<List<String>> get userResponse =>
      _userResponse.stream.asBroadcastStream();
  static late String chatId;

  static void setMyChatId(String myChatID) {
    chatId = myChatID;
  }

  static void sendMessage(String message) {
    _socket.emit(
        'sendMessage', Chat(chat: chatId, content: message, sender: userID));
  }

  static void connectAndListen(chatId) {
    setMyChatId(chatId);
    // broadcast stream make stream listen one time only
    StreamController<Chat> _socketResponse = StreamController<Chat>();
    StreamController<List<String>> _userResponse =
        StreamController<List<String>>();

    _socket = io.io(
        serverUrl,
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .build());

    _socket.connect();

    _socket.onConnect((data) => {
          print('Connected to server'),
          _socket.emit('joinChat', chatId),
          _socket.emit('GetMessages', {'MeId': userId, 'ChatId': chatId})
        });

    _socket.on(
        'newMessage',
        (data) => {
              _socketResponse.sink.add(Chat.fromRawJson(data)),
              print(data),
            });

    //When an event received from server, data is added to the stream
    _socket.on('sendMessage', (data) {
      print('Received message from server');
    });

    _socket.on('joinChat', (data) {
      print("joined chat");
    });

    //when users are connected or disconnected
    _socket.on('users', (data) {
      var users = (data as List<dynamic>).map((e) => e.toString()).toList();
      _userResponse.sink.add(users);
    });
  }

  static void dispose() {
    _socket.dispose();
    _socket.destroy();
    _socket.close();
    _socket.disconnect();
    socketResponse.close();
    _userResponse.close();
  }
}

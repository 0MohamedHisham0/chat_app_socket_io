import 'package:chat_app_socket_io/views/chat/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../model/chat_model.dart';
import '../../../model/get_chat_model.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'online_events.dart';

class ChatCubit extends Bloc<OnlineEvent, OnlineState> {
  late final io.Socket _socket;
  var chats = <Chat>[];
  GetChatModel? getChatModel;
  late String chatId;
  bool gotOldChats = false;

  //set chat id
  void setChatId(String id) {
    chatId = id;
  }

  // get chat id

  ChatCubit() : super(OnlineInitial()) {
    _socket = io.io(
        serverUrl,
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .build());

    _socket.connect();
    _socket.onConnecting((data) => add(OnlineConnectingEvent()));
    _socket.onConnect((data) => add(OnlineConnectedEvent()));
    _socket.onConnectError((data) => add(OnlineConnectErrorEvent(data)));
    _socket.onConnectTimeout((data) => add(OnlineConnectTimeoutEvent(data)));
    _socket.onDisconnect((data) => add(OnlineDisconnectEvent()));
    _socket.onError((data) => add(OnlineErrorEvent(data)));
    _socket.on(
        'newMessage',
        (data) => {
              chats.add(Chat(
                  chat: chatId,
                  content: data['content'],
                  sender: data['sender'])),
              print(data),
              add(const OnlineNewMessageEvent()),
            });
  }

  String get getChatId => chatId;

  static ChatCubit get(context) => BlocProvider.of(context);

  void sendMessage(String message, String chatID) {
    _socket.emit(
        'sendMessage', Chat(chat: chatID, content: message, sender: userID));
    add(OnlineSendMessageEvent());
    print(message);
  }

  void connectSocket(String chatID) {
    _socket.connect();
    chatId = chatID;
  }

  @override
  Stream<OnlineState> mapEventToState(OnlineEvent event) async* {
    if (event is OnlineConnectingEvent) {
      yield OnlineConnectingState();
      print('Connecting');
    } else if (event is OnlineConnectedEvent) {
      yield OnlineConnectedState();
      print('Connected to server');
      print(chatId);
      _socket.emit('joinChat', chatId);
      _socket.emit('GetMessages', {'MeId': userID, 'ChatId': chatId});
    } else if (event is OnlineConnectErrorEvent) {
      yield OnlineConnectErrorState(event.error);
    } else if (event is OnlineConnectTimeoutEvent) {
      yield OnlineConnectTimeoutState(event.error);
    } else if (event is OnlineDisconnectEvent) {
      yield OnlineDisconnectState();
    } else if (event is OnlineErrorEvent) {
      yield OnlineErrorState(event.error);
    } else if (event is OnlineSendMessageEvent) {
      yield OnlineSendMessageState();
    } else if (event is OnlineNewMessageEvent) {
      print('New message');
      yield OnlineNewMessageState();
    }
    if (event is OnlineChatGetChatSuccessEvent) {
      yield OnlineChatGetChatSuccessState();
    }
  }

  @override
  Future<void> close() {
    _socket.dispose();
    return super.close();
  }

  void dispose() {
    _socket.dispose();
    _socket.destroy();
    _socket.close();
    _socket.disconnect();
  }

  void getFriendChat(String chatID) {
    if (gotOldChats == false) {
      DioHelper.getData(url: GET_CHAT_BY_ID + chatID, token: token)
          .then((value) {
        getChatModel = GetChatModel.fromJson(value.data);
        getChatModel!.messages!.forEach((element) {
          var data = Chat(
            chat: chatID,
            content: element.content,
            sender: element.sender,
          );
          gotOldChats = true;
          chats.add(data);
        });
        add(const OnlineChatGetChatSuccessEvent());
        print(value.data);
      }).catchError((error) {
        print(error);
      });
    }
  }
}

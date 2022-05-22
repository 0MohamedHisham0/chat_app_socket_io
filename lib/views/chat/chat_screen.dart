import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'message_view.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, this.userName, this.chatId}) : super(key: key);

  String? userName, chatId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ChatCubit();
      },
      child: BlocConsumer<ChatCubit, OnlineState>(
        listener: (context, state) {
          if (state is OnlineConnectingState) {
            print('Connecting');
          }
        },
        builder: (context, state) {
          var _scrollController = ScrollController();
          void _scrollDown() {
            try {
              print('scroll down');
              Timer(const Duration(milliseconds: 300),
                      () => _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent));
            } on Exception catch (_) {}
          }

          var cubit = ChatCubit.get(context);
          cubit.setChatId(chatId!);
          cubit.getFriendChat(chatId!);
          // SocketService.connectAndListen(chatId);

          var textController = TextEditingController();
          var focusCode = FocusNode();

          void sendMessage() {
            var message = textController.text;
            if (message.isNotEmpty) {
              print(chatId);
              cubit.sendMessage(message, chatId!);
              // SocketService.sendMessage(message);
              textController.clear();
              focusCode.requestFocus();
            }
          }

          _scrollDown();
          return WillPopScope(
            onWillPop: () {
              cubit.dispose();
              return Future.value(true);
            },
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: mainColorMaterial),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  userName.toString(),
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: mainColorMaterial),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ConditionalBuilder(
                        condition: cubit.chats.isNotEmpty && cubit.gotOldChats,
                        builder: (context) {
                          if (state is OnlineChatGetChatSuccessState ||
                              state is OnlineChatGetChatSuccessState) {
                            _scrollDown();
                          }
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: cubit.chats.length,
                            itemBuilder: (BuildContext context, int index) =>
                                MessageView(chat: cubit.chats[index]),
                          );
                        },
                        fallback: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      margin: const EdgeInsets.all(12),
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onTap: (){
                                _scrollDown();
                              },

                              focusNode: focusCode,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.send,
                              autofocus: true,
                              controller: textController,
                              onSubmitted: (s) => sendMessage(),
                              decoration: const InputDecoration(
                                  hintText: 'Send a message',
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              sendMessage();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

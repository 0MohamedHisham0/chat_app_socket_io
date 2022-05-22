import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/chat_model.dart';
import '../../model/get_chat_model.dart';
import '../../shared/components/constants.dart';

class MessageView extends StatelessWidget {
  final Chat chat;

  MessageView({Key? key, required this.chat}) : super(key: key);
  final f = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    if (chat.sender == null) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          chat.content ?? '',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }

    var size = MediaQuery.of(context).size;
    // bool isSendByUser = chat.sender == SocketService.userId;
    bool isSendByUser = false;

    if (chat.sender == userID) {
      isSendByUser = true;
    }

    return Align(
      alignment: isSendByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 4, 8, 0),
        child: Column(
          crossAxisAlignment:
              isSendByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Container(
                padding: const EdgeInsets.all(11),
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.5,
                  minWidth: size.width * 0.01,
                ),
                decoration: BoxDecoration(
                    borderRadius: isSendByUser
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )
                        : const BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                    color: isSendByUser
                        ? const Color(mainColor)
                        : Colors.grey.shade500),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        chat.content ?? 'none',
                        style:
                            const TextStyle(fontSize: 17, color: Colors.white),
                        softWrap: true,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class MessageViewResponse extends StatelessWidget {
  final Messages chat;

  MessageViewResponse({Key? key, required this.chat}) : super(key: key);
  final f = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    if (chat.sender == null) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          chat.content ?? '',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }

    var size = MediaQuery.of(context).size;
    // bool isSendByUser = chat.sender == SocketService.userId;
    bool isSendByUser = false;

    if (chat.sender == userID) {
      isSendByUser = true;
    }

    return Align(
      alignment: isSendByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 4, 8, 0),
        child: Column(
          crossAxisAlignment:
              isSendByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Container(
                padding: const EdgeInsets.all(11),
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.5,
                  minWidth: size.width * 0.01,
                ),
                decoration: BoxDecoration(
                    borderRadius: isSendByUser
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )
                        : const BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                    color: isSendByUser
                        ? const Color(mainColor)
                        : Colors.grey.shade500),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        chat.content ?? 'none',
                        style:
                            const TextStyle(fontSize: 17, color: Colors.white),
                        softWrap: true,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

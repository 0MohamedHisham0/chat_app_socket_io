import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app_socket_io/shared/cubit/cubit.dart';
import 'package:chat_app_socket_io/shared/cubit/states.dart';
import 'package:chat_app_socket_io/views/all_users/all_users_screen.dart';

import '../../service/socket_service.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../chat/chat_screen.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userImageUrl =
        'https://i.pinimg.com/564x/e7/85/de/e785de451ef377349afdf04952ff0158.jpg';

    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ChatAppCubit.get(context);
        proceed(chatId, userName) {
          cubit.connectAndListen(chatId);
          cubit.getFriendChat(chatId);
          navigateTo(
              context,
              ChatScreen(
                userName: userName,
                chatId: chatId,
              ));
        }

        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context,
                  AllUsersScreen(myFriends: cubit.getMyFriendsModel!.friends!));
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleSpacing: 20.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(userImageUrl),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                const Text(
                  'My Friends',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.getMyFriendsModel != null,
                    builder: (context) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                              color: Colors.grey[300],
                            ),
                            padding: const EdgeInsets.all(
                              5.0,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.search,
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    'Search',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => buildChatItem(
                                avatarUrl:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrpGMzCk6bk1x-SDgwlg3Y6HxzQav_RsOSCQ&usqp=CAU',
                                isOnline: true,
                                lastMessage: 'latest message',
                                lastMessageTime: '12:00',
                                name: cubit
                                    .getMyFriendsModel!.friends![index].name
                                    .toString(),
                                onTop: () {
                                  proceed(
                                      cubit.getMyFriendsModel!.friends![index]
                                          .chatId
                                          .toString(),
                                      cubit.getMyFriendsModel!.friends![index]
                                          .name
                                          .toString());
                                }),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 4.0,
                            ),
                            itemCount: cubit.getMyFriendsModel!.friends!.length,
                          ),
                        ],
                      );
                    },
                    fallback: (context) => ConditionalBuilder(
                      condition: state is ChatAppGetMyFriendsLoadingState ||
                          state is ChatAppGetAllUsersLoadingState,
                      fallback: (context) => errorWidget(
                          state is ChatAppGetMyFriendsErrorState
                              ? state.error.toString()
                              : ''),
                      builder: (context) => Center(
                        child: (progressLoading()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildChatItem({
    required String name,
    required String lastMessage,
    required String lastMessageTime,
    required String avatarUrl,
    required bool isOnline,
    required Function onTop,
  }) =>
      InkWell(
        onTap: () {
          onTop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 3.0,
                      end: 3.0,
                    ),
                    child: isOnline == true
                        ? const CircleAvatar(
                            radius: 7.0,
                            backgroundColor: Colors.green,
                          )
                        : const CircleAvatar(
                            radius: 7.0,
                            backgroundColor: Colors.red,
                          ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Container(
                            width: 7.0,
                            height: 7.0,
                            decoration: const BoxDecoration(
                              color: Color(mainColor),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Text(
                          lastMessageTime,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

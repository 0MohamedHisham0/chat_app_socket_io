import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/get_friends_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({Key? key, required this.myFriends}) : super(key: key);

  final List<FriendsGetMyFriendsModel> myFriends;

  @override
  Widget build(BuildContext context) {
    var userImageUrl =
        'https://i.pinimg.com/564x/36/0e/6e/360e6e1318dd257c51f01f37cf27c862.jpg';
    var friendImageUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrpGMzCk6bk1x-SDgwlg3Y6HxzQav_RsOSCQ&usqp=CAU';

    return BlocConsumer<ChatAppCubit, ChatAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ChatAppCubit.get(context);
        if (cubit.getAllFriendsModel != null) {
          cubit.filteredFriendsList(myFriends);
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
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
                  'All Users',
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
                ConditionalBuilder(
                  condition: cubit.getAllFriendsModel != null,
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
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildChatItem(
                              avatarUrl: friendImageUrl,
                              isOnline: true,
                              lastMessage: 'latest message',
                              lastMessageTime: '12:00',
                              name: cubit.getAllFriendsModel!.users![index].name.toString(),
                              onTap: () {
                                cubit.startChat(
                                    cubit.getAllFriendsModel!.users![index].sId.toString(),
                                    cubit.getAllFriendsModel!.users![index].name
                                        .toString());
                              }),
                          separatorBuilder: (context, index) =>
                              const SizedBox(
                            height: 4.0,
                          ),
                          itemCount: cubit.getAllFriendsModel!.users!.length,
                        ),
                      ],
                    );
                  },
                  fallback: (context) => ConditionalBuilder(
                    condition: state is ChatAppGetAllUsersLoadingState,
                    fallback: (context) => errorWidget(
                        state is ChatAppGetAllUsersErrorState
                            ? state.error.toString()
                            : 'Something went wrong'),
                    builder: (context) => Center(
                      child: (progressLoading()),
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
    required Function onTap,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            onTap();
                          },
                          icon: const Icon(Icons.person_add_alt)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

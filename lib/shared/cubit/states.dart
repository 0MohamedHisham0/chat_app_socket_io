
abstract class ChatAppStates {}

class ChatAppInitialState extends ChatAppStates {}

class ChatAppGetMyFriendsLoadingState extends ChatAppStates {}

class ChatAppGetMyFriendsSuccessState extends ChatAppStates {}

class ChatAppGetMyFriendsErrorState extends ChatAppStates {
  final String error;

  ChatAppGetMyFriendsErrorState(this.error);
}
class ChatAppGetAllUsersLoadingState extends ChatAppStates {}

class ChatAppGetAllUsersSuccessState extends ChatAppStates {}

class ChatAppGetAllUsersErrorState extends ChatAppStates {
  final String error;

  ChatAppGetAllUsersErrorState(this.error);
}
class ChatAppGetChatSuccessState extends ChatAppStates {}
class ChatAppNewMessageState extends ChatAppStates {}

import 'package:equatable/equatable.dart';

abstract class OnlineEvent extends Equatable {
  const OnlineEvent();

  @override
  List<Object> get props => [];
}

class CheckUserOfflineOrNot extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class ActiveUser extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class InActiveUser extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class OnlineConnectingEvent extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class OnlineConnectedEvent extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class OnlineConnectErrorEvent extends OnlineEvent {
  const OnlineConnectErrorEvent(this.error);

  final String error;

  @override
  List<Object> get props => [];
}

class OnlineConnectTimeoutEvent extends OnlineEvent {
  const OnlineConnectTimeoutEvent(this.error);

  final String error;

  @override
  List<Object> get props => [];
}

class OnlineDisconnectEvent extends OnlineEvent {
  @override
  List<Object> get props => [];
}

class OnlineErrorEvent extends OnlineEvent {
  const OnlineErrorEvent(this.error);

  final String error;

  @override
  List<Object> get props => [];
}

class OnlineSendMessageEvent extends OnlineEvent {
  const OnlineSendMessageEvent();

  @override
  List<Object> get props => [];
}
class OnlineNewMessageEvent extends OnlineEvent {
  const OnlineNewMessageEvent();

  @override
  List<Object> get props => [];
}

class OnlineChatGetChatSuccessEvent extends OnlineEvent {
  const OnlineChatGetChatSuccessEvent();

  @override
  List<Object> get props => [];
}

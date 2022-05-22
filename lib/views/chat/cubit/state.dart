import 'package:equatable/equatable.dart';

abstract class OnlineState extends Equatable {
  const OnlineState();

  @override
  List<Object> get props => [];
}

class OnlineInitial extends OnlineState {}

class OnlineConnectingState extends OnlineState {}

class OnlineConnectedState extends OnlineState {}

class OnlineConnectErrorState extends OnlineState {
  const OnlineConnectErrorState(this.error);

  final String error;
}

class OnlineConnectTimeoutState extends OnlineState {
  const OnlineConnectTimeoutState(this.error);

  final String error;
}

class OnlineDisconnectState extends OnlineState {}

class OnlineErrorState extends OnlineState {
  const OnlineErrorState(this.error);

  final String error;
}

class OnlineSendMessageState extends OnlineState {}

class OnlineNewMessageState extends OnlineState {}

class OnlineChatGetChatSuccessState extends OnlineState {}

class CheckUserOfflineOrNotFailure extends OnlineState {
  final String error;

  const CheckUserOfflineOrNotFailure(this.error);
}


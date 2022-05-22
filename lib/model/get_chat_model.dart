class GetChatModel {
  String? isUser;
  List<Messages>? messages;
  Users? friendData;
  String? chatId;

  GetChatModel({this.isUser, this.messages, this.friendData, this.chatId});

  GetChatModel.fromJson(Map<String, dynamic> json) {
    isUser = json['isUser'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    friendData = json['friendData'] != null
        ? new Users.fromJson(json['friendData'])
        : null;
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isUser'] = this.isUser;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    if (this.friendData != null) {
      data['friendData'] = this.friendData!.toJson();
    }
    data['chatId'] = this.chatId;
    return data;
  }
}

class Messages {
  String? sId;
  ChatRespones? chat;
  String? content;
  String? sender;
  int? iV;

  Messages({this.sId, this.chat, this.content, this.sender, this.iV});

  Messages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chat = json['chat'] != null ? new ChatRespones.fromJson(json['chat']) : null;
    content = json['content'];
    sender = json['sender'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    data['content'] = this.content;
    data['sender'] = this.sender;
    data['__v'] = this.iV;
    return data;
  }
}

class ChatRespones {
  String? sId;
  List<Users>? users;
  int? iV;

  ChatRespones({this.sId, this.users, this.iV});

  ChatRespones.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Users {
  String? sId;
  String? name;
  String? email;

  Users({this.sId, this.name, this.email});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
class GetAllFriendsModel {
  String? message;
  bool? status;
  List<UsersAllFriendsModel>? users;

  GetAllFriendsModel({this.message, this.status, this.users});

  GetAllFriendsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['users'] != null) {
      users = <UsersAllFriendsModel>[];
      json['users'].forEach((v) {
        users!.add(new UsersAllFriendsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersAllFriendsModel {
  Null? socketId;
  String? sId;
  String? name;
  String? email;
  String? password;
  bool? isOnline;
  String? date;
  int? iV;
  List<Friends>? friends;

  UsersAllFriendsModel(
      {this.socketId,
        this.sId,
        this.name,
        this.email,
        this.password,
        this.isOnline,
        this.date,
        this.iV,
        this.friends});

  UsersAllFriendsModel.fromJson(Map<String, dynamic> json) {
    socketId = json['socketId'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    isOnline = json['isOnline'];
    date = json['date'];
    iV = json['__v'];
    if (json['friends'] != null) {
      friends = <Friends>[];
      json['friends'].forEach((v) {
        friends!.add(new Friends.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socketId'] = this.socketId;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['isOnline'] = this.isOnline;
    data['date'] = this.date;
    data['__v'] = this.iV;
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Friends {
  String? name;
  String? id;
  String? chatId;
  String? sId;

  Friends({this.name, this.id, this.chatId, this.sId});

  Friends.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    chatId = json['chatId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['chatId'] = this.chatId;
    data['_id'] = this.sId;
    return data;
  }
}
class SignUpModel {
  String? message;
  bool? status;
  String? token;
  User? user;

  SignUpModel({this.message, this.status, this.user});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    data['status'] = status;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? password;
  bool? isOnline;
  String? date;
  int? iV;
  List<Friends>? friends;

  User(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.isOnline,
        this.date,
        this.iV,
        this.friends});

  User.fromJson(Map<String, dynamic> json) {
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
        friends!.add(Friends.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
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




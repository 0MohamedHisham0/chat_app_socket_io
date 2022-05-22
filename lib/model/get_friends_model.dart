class GetMyFriendsModel {
  String? message;
  bool? status;
  List<FriendsGetMyFriendsModel>? friends;

  GetMyFriendsModel({this.message, this.status, this.friends});

  GetMyFriendsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['friends'] != null) {
      friends = <FriendsGetMyFriendsModel>[];
      json['friends'].forEach((v) {
        friends!.add(new FriendsGetMyFriendsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FriendsGetMyFriendsModel {
  String? name;
  String? id;
  String? chatId;
  Null? nId;

  FriendsGetMyFriendsModel({this.name, this.id, this.chatId, this.nId});

  FriendsGetMyFriendsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    chatId = json['chatId'];
    nId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['chatId'] = this.chatId;
    data['_id'] = this.nId;
    return data;
  }
}
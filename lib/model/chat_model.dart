class Chat {
  final String? chat;
  final String? content;
  final String? sender;


  Chat({
    this.chat,
    this.content,
    this.sender,
  });

  factory Chat.fromRawJson(Map<String, dynamic> jsonData) {
    return Chat(
        chat: jsonData['chat'],
        content: jsonData['content'],
        sender: jsonData['sender'],);
    }

  Map<String, dynamic> toJson() {
    return {
      "chat": chat,
      "content": content,
      "sender": sender,
    };
  }
}

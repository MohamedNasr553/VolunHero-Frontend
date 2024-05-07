class ChatResponse {
  String message;
  List<Chat> chats;

  ChatResponse({
    required this.message,
    required this.chats,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      message: json['message'],
      chats: List<Chat>.from(json['chats'].map((x) => Chat.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'ChatResponse(message: $message, chats: $chats)';
  }
}

class Chat {
  String id;
  List<String> members;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Chat({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'],
      members: List<String>.from(json['members'].map((x) => x)),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  @override
  String toString() {
    return 'Chat(id: $id, members: $members, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }
}

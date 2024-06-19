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
  List<Member> members;
  List<Message> messages;

  Chat({
    required this.id,
    required this.members,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'],
      members: List<Member>.from(json['members'].map((x) => Member.fromJson(x))),
      messages: json['messages'] != null
          ? List<Message>.from(json['messages'].map((x) => Message.fromJson(x)))
          : [],
    );
  }

  @override
  String toString() {
    return 'Chat(id: $id, members: $members, messages: $messages)';
  }
}

class Member {
  User userId;

  Member({
    required this.userId,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      userId: User.fromJson(json['userId']),
    );
  }

  @override
  String toString() {
    return 'Member(userId: $userId)';
  }
}

class User {
  String id;
  String userName;
  String? profilePic;

  User({
    required this.id,
    required this.userName,
    this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['userName'],
      profilePic: json['profilePic'],
    );
  }

  @override
  String toString() {
    return 'User(id: $id, userName: $userName, profilePic: $profilePic)';
  }
}

class MessageResponse {
  String message;
  List<Message> messages;

  MessageResponse({
    required this.message,
    required this.messages,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      message: json['message'],
      messages: List<Message>.from(json['messages'].map((x) => Message.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'MessageResponse(message: $message, messages: $messages)';
  }
}

class Message {
  String id;
  String chatId;
  String senderId;
  String text;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      text: json['text'],
      isDeleted: json['isDeleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, chatId: $chatId, senderId: $senderId, text: $text, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }
}

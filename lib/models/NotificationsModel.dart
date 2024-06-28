import 'dart:convert';

// Notifications Model
class NotificationsModel {
  String message;
  List<NotificationModel> notifications;

  NotificationsModel({required this.message, required this.notifications});

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      message: json['message'],
      notifications: List<NotificationModel>.from(
        json['notifications'].map((notification) => NotificationModel.fromJson(notification)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'notifications': notifications.map((notification) => notification.toJson()).toList(),
    };
  }
  @override
  String toString() {
    return 'NotificationsModel(message: $message, notifications: $notifications)';
  }
}

// Notification Model
class NotificationModel {
  String id;
  String user;
  String sender;
  String type;
  String content;
  bool read;
  String relatedEntity;
  String entityModel;
  DateTime createdAt;
  int version;

  NotificationModel({
    required this.id,
    required this.user,
    required this.sender,
    required this.type,
    required this.content,
    required this.read,
    required this.relatedEntity,
    required this.entityModel,
    required this.createdAt,
    required this.version,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      user: json['user'],
      sender: json['sender'],
      type: json['type'],
      content: json['content'],
      read: json['read'],
      relatedEntity: json['relatedEntity'],
      entityModel: json['entityModel'],
      createdAt: DateTime.parse(json['createdAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'sender': sender,
      'type': type,
      'content': content,
      'read': read,
      'relatedEntity': relatedEntity,
      'entityModel': entityModel,
      'createdAt': createdAt.toIso8601String(),
      '__v': version,
    };
  }
}




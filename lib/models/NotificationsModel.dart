// Notifications Model
class NotificationsModel {
  String message;
  List<NotificationModelDetails> notifications;

  NotificationsModel({required this.message, required this.notifications});

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      message: json['message'],
      notifications: List<NotificationModelDetails>.from(
        json['notifications'].map((notification) => NotificationModelDetails.fromJson(notification)),
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
class NotificationModelDetails {
  String id;
  String user;
  Sender? sender; // Make sender nullable
  String type;
  String content;
  bool read;
  String relatedEntity;
  String entityModel;
  DateTime createdAt;
  int version;

  NotificationModelDetails({
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

  factory NotificationModelDetails.fromJson(Map<String, dynamic> json) {
    return NotificationModelDetails(
      id: json['_id'],
      user: json['user'],
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
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
      'sender': sender?.toJson(), // Handle null sender gracefully
      'type': type,
      'content': content,
      'read': read,
      'relatedEntity': relatedEntity,
      'entityModel': entityModel,
      'createdAt': createdAt.toIso8601String(),
      '__v': version,
    };
  }

  @override
  String toString() {
    return 'NotificationModelDetails(id: $id, user: $user, sender: $sender, type: $type, content: $content, read: $read, relatedEntity: $relatedEntity, entityModel: $entityModel, createdAt: $createdAt, version: $version)';
  }
}

// Sender Model
class Sender {
  String id;
  ProfilePic profilePic;

  Sender({required this.id, required this.profilePic});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'],
      profilePic: ProfilePic.fromJson(json['profilePic']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'profilePic': profilePic.toJson(),
    };
  }

  @override
  String toString() {
    return 'Sender(id: $id, profilePic: $profilePic)';
  }
}

// ProfilePic Model
class ProfilePic {
  String secureUrl;
  String publicId;

  ProfilePic({required this.secureUrl, required this.publicId});

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secureUrl,
      'public_id': publicId,
    };
  }

  @override
  String toString() {
    return 'ProfilePic(secureUrl: $secureUrl, publicId: $publicId)';
  }
}

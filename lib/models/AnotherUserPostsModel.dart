import 'dart:convert';

class AnotherUserPostsResponse {
  String message;
  List<PostWrapper> posts;

  AnotherUserPostsResponse({
    required this.message,
    required this.posts,
  });

  factory AnotherUserPostsResponse.fromJson(Map<String, dynamic> json) {
    var postsList = json['posts'] as List<dynamic>;
    List<PostWrapper> posts = postsList.map((postJson) => PostWrapper.fromJson(postJson)).toList();

    return AnotherUserPostsResponse(
      message: json['message'],
      posts: posts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'posts': posts.map((post) => post.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class PostWrapper {
  String id;
  String content;
  String specification;
  List<Attachment> attachments;
  AnotherUserData createdBy;
  AnotherUserData? sharedBy;
  AnotherUserPost? mainPost;
  AnotherUserPost? sharedFrom;
  String customId;
  int likesCount;
  int shareCount;
  int commentsCount;
  List<Like> likes;
  List<dynamic> sharedUsers;
  List<dynamic> comments;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isLikedByMe;

  PostWrapper({
    required this.id,
    required this.content,
    required this.specification,
    required this.attachments,
    required this.createdBy,
    this.sharedBy,
    this.mainPost,
    this.sharedFrom,
    required this.customId,
    required this.likesCount,
    required this.shareCount,
    required this.commentsCount,
    required this.likes,
    required this.sharedUsers,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLikedByMe,
  });

  factory PostWrapper.fromJson(Map<String, dynamic> json) {
    var attachmentsList = json['attachments'] as List<dynamic>;
    List<Attachment> attachments = attachmentsList.map((attachmentJson) => Attachment.fromJson(attachmentJson)).toList();

    var likesList = json['likes'] as List<dynamic>;
    List<Like> likes = likesList.map((likeJson) => Like.fromJson(likeJson)).toList();

    return PostWrapper(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      createdBy: AnotherUserData.fromJson(json['createdBy']),
      sharedBy: json['sharedBy'] != null ? AnotherUserData.fromJson(json['sharedBy']) : null,
      mainPost: json['mainPost'] != null ? AnotherUserPost.fromJson(json['mainPost']) : null,
      sharedFrom: json['sharedFrom'] != null ? AnotherUserPost.fromJson(json['sharedFrom']) : null,
      customId: json['customId'],
      likesCount: json['likesCount'],
      shareCount: json['shareCount'],
      commentsCount: json['commentsCount'],
      likes: likes,
      sharedUsers: List<dynamic>.from(json['sharedUsers']),
      comments: List<dynamic>.from(json['comments']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      isLikedByMe: json['isLikedByMe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'specification': specification,
      'attachments': attachments.map((attachment) => attachment.toJson()).toList(),
      'createdBy': createdBy.toJson(),
      'sharedBy': sharedBy?.toJson(),
      'mainPost': mainPost?.toJson(),
      'sharedFrom': sharedFrom?.toJson(),
      'customId': customId,
      'likesCount': likesCount,
      'shareCount': shareCount,
      'commentsCount': commentsCount,
      'likes': likes.map((like) => like.toJson()).toList(),
      'sharedUsers': sharedUsers,
      'comments': comments,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'v': v,
      'isLikedByMe': isLikedByMe,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class AnotherUserData {
  String id;
  String userName;
  String role;
  ProfilePic? profilePic;

  AnotherUserData({
    required this.id,
    required this.userName,
    required this.role,
    this.profilePic,
  });

  factory AnotherUserData.fromJson(Map<String, dynamic> json) {
    return AnotherUserData(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'] != null ? ProfilePic.fromJson(json['profilePic']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'role': role,
      'profilePic': profilePic?.toJson(),
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class ProfilePic {
  String secureUrl;
  String publicId;

  ProfilePic({
    required this.secureUrl,
    required this.publicId,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secureUrl': secureUrl,
      'publicId': publicId,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class AnotherUserPost {
  String id;
  String content;
  String specification;
  List<Attachment> attachments;
  String createdBy;
  int likesCount;
  int shareCount;
  int commentsCount;
  List<Like> likes;
  List<dynamic> sharedUsers;
  List<dynamic> comments;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  AnotherUserPost({
    required this.id,
    required this.content,
    required this.specification,
    required this.attachments,
    required this.createdBy,
    required this.likesCount,
    required this.shareCount,
    required this.commentsCount,
    required this.likes,
    required this.sharedUsers,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AnotherUserPost.fromJson(Map<String, dynamic> json) {
    var attachmentsList = json['attachments'] as List<dynamic>;
    List<Attachment> attachments = attachmentsList.map((attachmentJson) => Attachment.fromJson(attachmentJson)).toList();

    var likesList = json['likes'] as List<dynamic>;
    List<Like> likes = likesList.map((likeJson) => Like.fromJson(likeJson)).toList();

    return AnotherUserPost(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      createdBy: json['createdBy'],
      likesCount: json['likesCount'],
      shareCount: json['shareCount'],
      commentsCount: json['commentsCount'],
      likes: likes,
      sharedUsers: List<dynamic>.from(json['sharedUsers']),
      comments: List<dynamic>.from(json['comments']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'specification': specification,
      'attachments': attachments.map((attachment) => attachment.toJson()).toList(),
      'createdBy': createdBy,
      'likesCount': likesCount,
      'shareCount': shareCount,
      'commentsCount': commentsCount,
      'likes': likes.map((like) => like.toJson()).toList(),
      'sharedUsers': sharedUsers,
      'comments': comments,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'v': v,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class Attachment {
  String secureUrl;
  String publicId;

  Attachment({
    required this.secureUrl,
    required this.publicId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secureUrl': secureUrl,
      'publicId': publicId,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class Like {
  String userId;
  String id;

  Like({
    required this.userId,
    required this.id,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      userId: json['userId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class SharedUser {
  String userId;
  String id;

  SharedUser({
    required this.userId,
    required this.id,
  });

  factory SharedUser.fromJson(Map<String, dynamic> json) {
    return SharedUser(
      userId: json['userId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

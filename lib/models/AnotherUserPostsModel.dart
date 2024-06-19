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

  @override
  String toString() {
    return jsonEncode({
      'message': message,
      'posts': posts.map((post) => post.toJson()).toList(),
    });
  }
}

class PostWrapper {
  String id;
  User userId;
  Post? post;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PostWrapper({
    required this.id,
    required this.userId,
    this.post,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory PostWrapper.fromJson(Map<String, dynamic> json) {
    return PostWrapper(
      id: json['_id'],
      userId: User.fromJson(json['userId']),
      post: json['post'] != null ? Post.fromJson(json['post']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId.toJson(),
      'post': post?.toJson(),
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

class User {
  String id;
  String userName;
  String role;
  String? profilePic;

  User({
    required this.id,
    required this.userName,
    required this.role,
    this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'role': role,
      'profilePic': profilePic,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class Post {
  String id;
  String content;
  String specification;
  List<Attachment>? attachments;
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

  Post({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
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

  factory Post.fromJson(Map<String, dynamic> json) {
    var attachmentsList = json['attachments'] as List<dynamic>? ?? [];
    List<Attachment> attachments = attachmentsList.map((attachmentJson) => Attachment.fromJson(attachmentJson)).toList();

    var likesList = json['likes'] as List<dynamic>;
    List<Like> likes = likesList.map((likeJson) => Like.fromJson(likeJson)).toList();

    return Post(
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
      'attachments': attachments?.map((attachment) => attachment.toJson()).toList(),
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

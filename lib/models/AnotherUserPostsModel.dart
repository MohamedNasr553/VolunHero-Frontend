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
    List<PostWrapper> posts =
        postsList.map((postJson) => PostWrapper.fromJson(postJson)).toList();

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
  List<AnotherUserAttachment> attachments;
  CreatedBy createdBy;
  SharedBy? sharedBy;
  String? mainPost;
  String? sharedFrom;
  int likesCount;
  int shareCount;
  int commentsCount;
  List<Comment> comments;
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
    required this.likesCount,
    required this.shareCount,
    required this.commentsCount,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLikedByMe,
  });

  factory PostWrapper.fromJson(Map<String, dynamic> json) {
    var attachmentsList = json['attachments'] as List<dynamic>;
    List<AnotherUserAttachment> attachments = attachmentsList
        .map((attachmentJson) => AnotherUserAttachment.fromJson(attachmentJson))
        .toList();

    var commentsList = json['comments'] as List<dynamic>;
    List<Comment> comments = commentsList
        .map((commentJson) => Comment.fromJson(commentJson))
        .toList();

    return PostWrapper(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      createdBy: CreatedBy.fromJson(json['createdBy']),
      sharedBy:
      json['sharedBy'] != null ? SharedBy.fromJson(json['sharedBy']) : null,
      mainPost: json['mainPost'],
      sharedFrom: json['sharedFrom'],
      likesCount: json['likesCount'],
      shareCount: json['shareCount'],
      commentsCount: json['commentsCount'],
      comments: comments,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      isLikedByMe: json['isLikedByMe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'specification': specification,
      'attachments':
          attachments.map((attachment) => attachment.toJson()).toList(),
      'createdBy': createdBy,
      'sharedBy': sharedBy,
      'mainPost': mainPost,
      'sharedFrom': sharedFrom,
      'likesCount': likesCount,
      'shareCount': shareCount,
      'commentsCount': commentsCount,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
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
      profilePic: json['profilePic'] != null
          ? ProfilePic.fromJson(json['profilePic'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
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
      'secure_url': secureUrl,
      'public_id': publicId,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class AnotherUserAttachment {
  String secureUrl;
  String publicId;

  AnotherUserAttachment({
    required this.secureUrl,
    required this.publicId,
  });

  factory AnotherUserAttachment.fromJson(Map<String, dynamic> json) {
    return AnotherUserAttachment(
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

class CreatedBy {
  String id;
  String userName;
  String role;
  ProfilePic? profilePic;

  CreatedBy({
    required this.id,
    required this.userName,
    required this.role,
    this.profilePic,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'] != null
          ? ProfilePic.fromJson(json['profilePic'])
          : null,
    );
  }

  @override
  String toString() {
    return 'CreatedBy: {id: $id, userName: $userName, role: $role, profilePic: $profilePic}';
  }
}

class SharedBy {
  String id;
  String userName;
  String role;
  ProfilePic? profilePic;

  SharedBy(
      {required this.id,
        required this.userName,
        required this.role,
        this.profilePic});

  factory SharedBy.fromJson(Map<String, dynamic> json) {
    return SharedBy(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'] != null
          ? ProfilePic.fromJson(json['profilePic'])
          : null,
    );
  }
}

class Comment {
  String commentId;
  String id;

  Comment({
    required this.commentId,
    required this.id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      '_id': id,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

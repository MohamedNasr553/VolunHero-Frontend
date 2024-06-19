class OwnerPostsResponse {
  String message;
  List<Posts> newPosts;

  OwnerPostsResponse({
    required this.message,
    required this.newPosts,
  });

  factory OwnerPostsResponse.fromJson(Map<String, dynamic> json) {
    var newPostsList = json['posts'] as List<dynamic>? ?? [];
    List<Posts> newPosts = newPostsList
        .map((postJson) => Posts.fromJson(postJson))
        .toList();

    return OwnerPostsResponse(
      message: json['message'] ?? '',
      newPosts: newPosts,
    );
  }

  @override
  String toString() {
    return 'OwnerPostsResponse: {message: $message, newPosts: $newPosts}';
  }
}

class Posts {
  String id;
  String content;
  String specification;
  List<Attachments>? attachments;
  CreatedBy createdBy;
  String? customId;
  int likesCount;
  int shareCount;
  int commentsCount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Posts({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
    required this.createdBy,
    this.customId,
    required this.likesCount,
    required this.shareCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    var attachmentsList = json['attachments'] as List<dynamic>? ?? [];
    var attachments = attachmentsList
        .map((attachmentJson) => Attachments.fromJson(attachmentJson))
        .toList();

    return Posts(
      id: json['_id'] ?? '',
      content: json['content'] ?? '',
      specification: json['specification'] ?? '',
      attachments: attachments.isEmpty ? null : attachments,
      createdBy: CreatedBy.fromJson(json['createdBy'] ?? {}),
      customId: json['customId'],
      likesCount: json['likesCount'] ?? 0,
      shareCount: json['shareCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
    );
  }
}

class Attachments {
  String secure_url;
  String public_id;

  Attachments({
    required this.secure_url,
    required this.public_id,
  });

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      secure_url: json['secure_url'] ?? '',
      public_id: json['public_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secure_url,
      'public_id': public_id,
    };
  }
}

class CreatedBy {
  String id;
  String userName;
  String role;
  String? profilePic;

  CreatedBy({
    required this.id,
    required this.userName,
    required this.role,
    this.profilePic,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      role: json['role'] ?? '',
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'role': role,
      'profilePic': profilePic,
    };
  }
}

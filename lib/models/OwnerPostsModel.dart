class OwnerPostsResponse {
  String message;
  List<Posts> newPosts;

  OwnerPostsResponse({
    required this.message,
    required this.newPosts,
  });

  factory OwnerPostsResponse.fromJson(Map<String, dynamic> json) {
    var newPostsList = json['posts'] as List<dynamic>;
    List<Posts> posts = newPostsList
        .map((postJson) => Posts.fromJson(postJson))
        .toList();

    return OwnerPostsResponse(
      message: json['message'],
      newPosts: posts,
    );
  }
}

class Posts {
  String id;
  String content;
  String specification;
  List<Attachments>? attachments;
  CreatedBy createdBy;
  SharedBy? sharedBy;
  String? mainPost;
  String? sharedFrom;
  String? customId;
  int likesCount;
  int shareCount;
  int commentsCount;
  List<ProfilePageComment>? comments;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isLikedByMe;

  Posts({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
    required this.createdBy,
    this.sharedBy,
    this.mainPost,
    this.sharedFrom,
    this.customId,
    required this.likesCount,
    required this.commentsCount,
    required this.shareCount,
    this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLikedByMe,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    var attachments = <Attachments>[];
    if (json.containsKey('attachments') && json['attachments'] != null) {
      json['attachments'].forEach((element) {
        attachments.add(Attachments.fromJson(element));
      });
    }

    var commentsList = json['comments'] as List<dynamic>;
    List<ProfilePageComment> comments = commentsList
        .map((commentJson) => ProfilePageComment.fromJson(commentJson))
        .toList();

    return Posts(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments.isEmpty ? null : attachments,
      createdBy: CreatedBy.fromJson(json['createdBy']),
      sharedBy:
      json['sharedBy'] != null ? SharedBy.fromJson(json['sharedBy']) : null,
      mainPost: json['mainPost'],
      sharedFrom: json['sharedFrom'],
      customId: json['customId'],
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      shareCount: json['shareCount'],
      comments: comments,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      isLikedByMe: json['isLikedByMe'],
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
      secure_url: json['secure_url'],
      public_id: json['public_id'],
    );
  }

  @override
  String toString() {
    return 'Attachment: {secureUrl: $secure_url, publicId: $public_id}';
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

  SharedBy({
    required this.id,
    required this.userName,
    required this.role,
    this.profilePic,
  });

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

  @override
  String toString() {
    return 'SharedBy: {id: $id, userName: $userName, role: $role, profilePic: $profilePic}';
  }
}

class ProfilePic {
  String secure_url;
  String public_id;

  ProfilePic({
    required this.secure_url,
    required this.public_id,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      secure_url: json['secure_url'],
      public_id: json['public_id'],
    );
  }

  @override
  String toString() {
    return 'ProfilePic: {secureUrl: $secure_url, publicId: $public_id}';
  }
}

class ProfilePageComment {
  String commentId;
  String id;

  ProfilePageComment({
    required this.commentId,
    required this.id,
  });

  factory ProfilePageComment.fromJson(Map<String, dynamic> json) {
    return ProfilePageComment(
      commentId: json['commentId'],
      id: json['_id'],
    );
  }

  @override
  String toString() {
    return 'HomePageComment: {commentId: $commentId, id: $id}';
  }
}

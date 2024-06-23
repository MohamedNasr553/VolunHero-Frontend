class HomePagePostsResponse {
  String message;
  List<ModifiedPost> modifiedPosts;

  HomePagePostsResponse({
    required this.message,
    required this.modifiedPosts,
  });

  factory HomePagePostsResponse.fromJson(Map<String, dynamic> json) {
    var modifiedPostsList = json['modifiedPosts'] as List<dynamic>;
    List<ModifiedPost> posts = modifiedPostsList
        .map((postJson) => ModifiedPost.fromJson(postJson))
        .toList();

    return HomePagePostsResponse(
      message: json['message'],
      modifiedPosts: posts,
    );
  }

  @override
  String toString() {
    return 'HomePagePostsResponse: {message: $message, modifiedPosts: $modifiedPosts}';
  }
}

class ModifiedPost {
  String id;
  String content;
  String specification;
  List<Attachment>? attachments;
  CreatedBy createdBy;
  String? customId;
  int likesCount;
  int shareCount;
  int commentsCount;
  List<HomePageComment> comments;
  DateTime createdAt;
  DateTime updatedAt;
  bool liked;
  int v;

  ModifiedPost({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
    required this.createdBy,
    this.customId,
    required this.likesCount,
    required this.commentsCount,
    required this.shareCount,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.liked,
    required this.v,
  });

  factory ModifiedPost.fromJson(Map<String, dynamic> json) {
    var attachments = <Attachment>[];
    if (json.containsKey('attachments') && json['attachments'] != null) {
      json['attachments'].forEach((element) {
        attachments.add(Attachment.fromJson(element));
      });
    }

    var commentsList = json['comments'] as List<dynamic>;
    List<HomePageComment> comments = commentsList
        .map((commentJson) => HomePageComment.fromJson(commentJson))
        .toList();

    return ModifiedPost(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      createdBy: CreatedBy.fromJson(json['createdBy']),
      customId: json['customId'],
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      shareCount: json['shareCount'],
      comments: comments,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      liked: false,
      v: json['__v'],
    );
  }
}

class Attachment {
  String secure_url;
  String public_id;

  Attachment({
    required this.secure_url,
    required this.public_id,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      secure_url: json['secure_url'],
      public_id: json['public_id'],
    );
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
      profilePic: json['profilePic'] != null ? ProfilePic.fromJson(json['profilePic']) : null,
    );
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
}

class HomePageComment {
  String commentId;
  String id;

  HomePageComment({
    required this.commentId,
    required this.id,
  });

  factory HomePageComment.fromJson(Map<String, dynamic> json) {
    return HomePageComment(
      commentId: json['commentId'],
      id: json['_id'],
    );
  }
}

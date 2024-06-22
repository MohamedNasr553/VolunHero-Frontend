class GetCommentsResponse {
  String message;
  List<Comment> comments;

  GetCommentsResponse({
    required this.message,
    required this.comments,
  });

  factory GetCommentsResponse.fromJson(Map<String, dynamic> json) {
    var commentsList = json['comments'] as List;
    List<Comment> comments = commentsList.map((e) => Comment.fromJson(e)).toList();

    return GetCommentsResponse(
      message: json['message'],
      comments: comments,
    );
  }
}

class Comment {
  String id;
  String content;
  String postId;
  CreatedBy createdBy;
  int likesCount;
  List<dynamic> likes;
  DateTime createdAt;
  DateTime updatedAt;
  int iV;

  Comment({
    required this.id,
    required this.content,
    required this.postId,
    required this.createdBy,
    required this.likesCount,
    required this.likes,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      content: json['content'],
      postId: json['postId'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      likesCount: json['likesCount'],
      likes: json['likes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      iV: json['__v'],
    );
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
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'],
    );
  }
}

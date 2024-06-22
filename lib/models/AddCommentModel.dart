class AddCommentResponse {
  String message;
  AddComment comment;

  AddCommentResponse({
    required this.message,
    required this.comment,
  });

  factory AddCommentResponse.fromJson(Map<String, dynamic> json) {
    return AddCommentResponse(
      message: json['message'],
      comment: AddComment.fromJson(json['comment']),
    );
  }
}

class AddComment {
  String? id;
  String? content;
  String? postId;
  String? createdBy;
  int? likesCount;
  List<dynamic>? likes;
  DateTime createdAt;
  DateTime updatedAt;
  int? iV;

  AddComment({
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

  factory AddComment.fromJson(Map<String, dynamic> json) {
    return AddComment(
      id: json['_id'],
      content: json['content'],
      postId: json['postId'],
      createdBy: json['createdBy'],
      likesCount: json['likesCount'],
      likes: json['likes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      iV: json['__v'],
    );
  }
}

class EditPostResponse {
  String message;
  List<EditPostDetails> post;

  EditPostResponse({
    required this.message,
    required this.post,
  });

  factory EditPostResponse.fromJson(Map<String, dynamic> json) {
    var newPostsList = json['posts'] as List<dynamic>? ?? [];
    List<EditPostDetails> newPosts = newPostsList
        .map((postJson) => EditPostDetails.fromJson(postJson))
        .toList();

    return EditPostResponse(
      message: json['message'] ?? '',
      post: newPosts,
    );
  }

  @override
  String toString() {
    return 'OwnerPostsResponse: {message: $message, newPosts: $post}';
  }
}

class EditPostDetails {
  String id;
  String content;
  String specification;
  List<Attachments>? attachments;
  String? customId;
  int likesCount;
  int shareCount;
  int commentsCount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  EditPostDetails({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
    this.customId,
    required this.likesCount,
    required this.shareCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory EditPostDetails.fromJson(Map<String, dynamic> json) {
    var attachmentsList = json['attachments'] as List<dynamic>? ?? [];
    var attachments = attachmentsList
        .map((attachmentJson) => Attachments.fromJson(attachmentJson))
        .toList();

    return EditPostDetails(
      id: json['_id'] ?? '',
      content: json['content'] ?? '',
      specification: json['specification'] ?? '',
      attachments: attachments.isEmpty ? null : attachments,
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
}

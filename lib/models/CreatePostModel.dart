class CreatePostsResponse {
  String message;
  List<Post> post;

  CreatePostsResponse({
    required this.message,
    required this.post,
  });

  factory CreatePostsResponse.fromJson(Map<String, dynamic> json) {
    var post = json['post'] as List<dynamic>;
    List<Post> posts = post
        .map((postJson) => Post.fromJson(postJson))
        .toList();

    return CreatePostsResponse(
      message: json['message'],
      post: posts,
    );
  }

  @override
  String toString() {
    return 'Create Posts Model: {message: $message, modifiedPosts: $Post}';
  }
}

class Post {
  String id;
  String content;
  String specification;
  List<Attachments> attachments;
  // CreatedBy createdBy;
  String createdBy;
  int likesCount;
  int shareCount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Post({
    required this.id,
    required this.content,
    required this.specification,
    required this.attachments,
    required this.createdBy,
    required this.likesCount,
    required this.shareCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var attachments = <Attachments>[];

    // Check if the "attachments" key exists in the JSON data
    if (json.containsKey('attachments') && json['attachments'] != null) {
      json['attachments'].forEach((element) {
        attachments.add(Attachments.fromJson(element));
      });
    }

    return Post(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      // createdBy: CreatedBy.fromJson(json['createdBy']),
      createdBy: json['createdBy'],
      likesCount: json['likesCount'],
      shareCount: json['shareCount'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
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
}

// class CreatedBy {
//   String id;
//   String userName;
//   String role;
//   String? profilePic;
//
//   CreatedBy({
//     required this.id,
//     required this.userName,
//     required this.role,
//     this.profilePic,
//   });
//
//   factory CreatedBy.fromJson(Map<String, dynamic> json) {
//     return CreatedBy(
//       id: json['_id'],
//       userName: json['userName'],
//       role: json['role'],
//       profilePic: json['profilePic'],
//     );
//   }
// }

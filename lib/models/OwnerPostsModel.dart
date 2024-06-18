class OwnerPostsResponse {
  String message;
  List<Posts> newPosts;

  OwnerPostsResponse({
    required this.message,
    required this.newPosts,
  });

  factory OwnerPostsResponse.fromJson(Map<String, dynamic> json) {
    var newPostsList = json['posts'] as List<dynamic>;
    List<Posts> newPosts = newPostsList
        .map((postJson) => Posts.fromJson(postJson))
        .toList();

    return OwnerPostsResponse(
      message: json['message'],
      newPosts: newPosts,
    );
  }

  @override
  String toString() {
    return 'HomePagePostsModel: {message: $message, modifiedPosts: $newPosts}';
  }
}

class Posts {
  String id;
  String content;
  String specification;
  List<Attachments>? attachments;
  String createdBy;
  // String? customId;
  int likesCount;
  int shareCount;
  DateTime createdAt;
  DateTime updatedAt;
  // bool liked;
  int v;

  Posts({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
    required this.createdBy,
    // this.customId,
    required this.likesCount,
    required this.shareCount,
    required this.createdAt,
    required this.updatedAt,
    // required this.liked,
    required this.v,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    var attachments = <Attachments>[];

    // Check if the "attachments" key exists in the JSON data
    if (json.containsKey('attachments') && json['attachments'] != null) {
      json['attachments'].forEach((element) {
        attachments.add(Attachments.fromJson(element));
      });
    }

    return Posts(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      createdBy: json['createdBy'],
      // customId: json['customId'],
      likesCount: json['likesCount'],
      shareCount: json['shareCount'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      // liked: false,
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

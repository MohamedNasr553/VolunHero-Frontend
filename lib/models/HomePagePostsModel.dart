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
    return 'HomePagePostsModel: {message: $message, modifiedPosts: $modifiedPosts}';
  }
}

class ModifiedPost {
  String id;
  String content;
  String specification;
  List<Attachments> attachments;
  CreatedBy createdBy;
  int likesCount;
  int shareCount;
  DateTime createdAt;
  DateTime updatedAt;
  bool liked = false;
  int v;

  ModifiedPost({
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

  factory ModifiedPost.fromJson(Map<String, dynamic> json) {
    var attachments = <Attachments>[];

    // Check if the "attachments" key exists in the JSON data
    if (json.containsKey('attachments') && json['attachments'] != null) {
      json['attachments'].forEach((element) {
        attachments.add(Attachments.fromJson(element));
      });
    }

    return ModifiedPost(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      createdBy: CreatedBy.fromJson(json['createdBy']),
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

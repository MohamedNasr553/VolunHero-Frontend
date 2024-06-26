class GetSavedPostsResponse {
  String? message;
  List<GetSavedPosts>? savedPosts;

  GetSavedPostsResponse({this.message, this.savedPosts});

  factory GetSavedPostsResponse.fromJson(Map<String, dynamic> json) {
    return GetSavedPostsResponse(
      message: json['message'],
      savedPosts: (json['savedPosts'] as List?)
          ?.map((i) => GetSavedPosts.fromJson(i))
          .toList(),
    );
  }
}

class GetSavedPosts {
  String? id;
  String? userId;
  List<GetDetailedSavedPost>? posts;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  GetSavedPosts(
      {this.id,
      this.userId,
      this.posts,
      this.createdAt,
      this.updatedAt,
      this.v});

  factory GetSavedPosts.fromJson(Map<String, dynamic> json) {
    return GetSavedPosts(
      id: json['_id'],
      userId: json['userId'],
      posts: (json['posts'] as List?)
          ?.map((i) => GetDetailedSavedPost.fromJson(i))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class GetDetailedSavedPost {
  String? postId;
  String? id;

  GetDetailedSavedPost({this.postId, this.id});

  factory GetDetailedSavedPost.fromJson(Map<String, dynamic> json) {
    return GetDetailedSavedPost(
      postId: json['postId'],
      id: json['_id'],
    );
  }
}

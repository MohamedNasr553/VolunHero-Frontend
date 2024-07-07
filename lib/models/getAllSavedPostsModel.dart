class GetSavedPostsResponse {
  String? message;
  GetSavedPosts? savedPosts;

  GetSavedPostsResponse({this.message, this.savedPosts});

  factory GetSavedPostsResponse.fromJson(Map<String, dynamic> json) {
    return GetSavedPostsResponse(
      message: json['message'],
      savedPosts: json['savedPosts'] != null
          ? GetSavedPosts.fromJson(json['savedPosts'])
          : null,
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

  factory GetSavedPosts.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return GetSavedPosts();
    }
    return GetSavedPosts(
      id: json['_id'],
      userId: json['userId'],
      posts: (json['posts'] as List?)
          ?.map((e) => GetDetailedSavedPost.fromJson(e))
          .toList(),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }
}

class GetDetailedSavedPost {
  String? postId;
  String? id;
  bool? isLikedByMe;

  GetDetailedSavedPost({this.postId, this.id, this.isLikedByMe});

  factory GetDetailedSavedPost.fromJson(Map<String, dynamic> json) {
    return GetDetailedSavedPost(
      postId: json['postId'],
      id: json['_id'],
      isLikedByMe: json['isLikedByMe'],
    );
  }
}

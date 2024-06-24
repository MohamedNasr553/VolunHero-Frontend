class GetSavedPostsResponse {
  String? message;
  List<GetSavedPosts>? savedPosts;

  GetSavedPostsResponse({this.message, this.savedPosts});

  factory GetSavedPostsResponse.fromJson(Map<String, dynamic> json) {
    return GetSavedPostsResponse(
      message: json['message'],
      savedPosts: json['savedPosts'] != null
          ? List<GetSavedPosts>.from(
          json['savedPosts'].map((v) => GetSavedPosts.fromJson(v)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'savedPosts': savedPosts?.map((v) => v.toJson()).toList(),
    };
  }
}

class GetSavedPosts {
  String id;
  String userId;
  List<GetDetailedSavedPost>? posts;
  DateTime createdAt;
  DateTime updatedAt;
  int iV;

  GetSavedPosts({
    required this.id,
    required this.userId,
    required this.posts,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
  });

  factory GetSavedPosts.fromJson(Map<String, dynamic> json) {
    return GetSavedPosts(
      id: json['_id'],
      userId: json['userId'],
      posts: json['posts'] != null
          ? List<GetDetailedSavedPost>.from(
          json['posts'].map((v) => GetDetailedSavedPost.fromJson(v)))
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'posts': posts?.map((v) => v.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': iV,
    };
  }
}

class GetDetailedSavedPost {
  String? postId;
  String? sId;

  GetDetailedSavedPost({this.postId, this.sId});

  factory GetDetailedSavedPost.fromJson(Map<String, dynamic> json) {
    return GetDetailedSavedPost(
      postId: json['postId'],
      sId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      '_id': sId,
    };
  }
}

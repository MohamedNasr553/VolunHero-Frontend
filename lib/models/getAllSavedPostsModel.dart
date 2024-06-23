class GetSavedPostsResponse {
  String? message;
  List<GetSavedPosts>? savedPosts;

  GetSavedPostsResponse({this.message, this.savedPosts});

  GetSavedPostsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['savedPosts'] != null) {
      savedPosts = <GetSavedPosts>[];
      json['savedPosts'].forEach((v) {
        savedPosts!.add(GetSavedPosts.fromJson(v));
      });
    }
  }
}

class GetSavedPosts {
  String? id;
  String? userId;
  List<GetDetailedSavedPost>? posts;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetSavedPosts(
      {this.id,
        this.userId,
        this.posts,
        this.createdAt,
        this.updatedAt,
        this.iV});

  GetSavedPosts.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    if (json['posts'] != null) {
      posts = <GetDetailedSavedPost>[];
      json['posts'].forEach((v) {
        posts!.add(GetDetailedSavedPost.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class GetDetailedSavedPost {
  String? postId;
  String? sId;

  GetDetailedSavedPost({this.postId, this.sId});

  GetDetailedSavedPost.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    sId = json['_id'];
  }
}

class SavedPostsResponse {
  String message;
  List<SavedPost> savedPosts;

  SavedPostsResponse({
    required this.message,
    required this.savedPosts,
  });

  factory SavedPostsResponse.fromJson(Map<String, dynamic> json) {
    var savedPostsList = json['savedPosts'] as List<dynamic>;
    List<SavedPost> posts = savedPostsList.map((postJson) => SavedPost.fromJson(postJson)).toList();

    return SavedPostsResponse(
      message: json['message'],
      savedPosts: posts,
    );
  }

  @override
  String toString() {
    return 'HomePageSavedPostsResponse: {message: $message, savedPosts: $savedPosts}';
  }
}

class SavedPost {
  String id;
  String userId;
  List<Post> posts;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SavedPost({
    required this.id,
    required this.userId,
    required this.posts,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SavedPost.fromJson(Map<String, dynamic> json) {
    var postsList = json['posts'] as List<dynamic>;
    List<Post> posts = postsList.map((postJson) => Post.fromJson(postJson)).toList();

    return SavedPost(
      id: json['_id'],
      userId: json['userId'],
      posts: posts,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  @override
  String toString() {
    return 'SavedPost: {id: $id, userId: $userId, posts: $posts, createdAt: $createdAt, updatedAt: $updatedAt, v: $v}';
  }
}

class Post {
  String postId;
  String id;

  Post({
    required this.postId,
    required this.id,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      id: json['_id'],
    );
  }

  @override
  String toString() {
    return 'Post: {postId: $postId, id: $id}';
  }
}

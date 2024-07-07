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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.savedPosts != null) {
      data['savedPosts'] = this.savedPosts!.toJson();
    }
    return data;
  }
}

class GetSavedPosts {
  String? id;
  String? userId;
  List<PostWrapper>? posts;
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
          ?.map((e) => PostWrapper.fromJson(e))
          .toList(),
      createdAt:
      json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
      json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['userId'] = this.userId;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt?.toIso8601String();
    data['updatedAt'] = this.updatedAt?.toIso8601String();
    data['__v'] = this.v;
    return data;
  }
}

class PostWrapper {
  PostObj? postObj;

  PostWrapper({this.postObj});

  factory PostWrapper.fromJson(Map<String, dynamic> json) {
    return PostWrapper(
      postObj: json['postObj'] != null ? PostObj.fromJson(json['postObj']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postObj != null) {
      data['postObj'] = this.postObj!.toJson();
    }
    return data;
  }
}

class PostObj {
  String? id;
  String? content;
  String? specification;
  List<Attachment>? attachments;
  CreatedBy? createdBy;
  String? sharedBy;
  String? mainPost;
  String? sharedFrom;
  String? customId;
  int? likesCount;
  int? shareCount;
  int? commentsCount;
  List<Like>? likes;
  List<SharedUser>? sharedUsers;
  List<Comment>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isLikedByMe;

  PostObj({
    this.id,
    this.content,
    this.specification,
    this.attachments,
    this.createdBy,
    this.sharedBy,
    this.mainPost,
    this.sharedFrom,
    this.customId,
    this.likesCount,
    this.shareCount,
    this.commentsCount,
    this.likes,
    this.sharedUsers,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isLikedByMe,
  });

  factory PostObj.fromJson(Map<String, dynamic> json) {
    return PostObj(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: (json['attachments'] as List?)
          ?.map((e) => Attachment.fromJson(e))
          .toList(),
      createdBy: json['createdBy'] != null ? CreatedBy.fromJson(json['createdBy']) : null,
      sharedBy: json['sharedBy'],
      mainPost: json['mainPost'],
      sharedFrom: json['sharedFrom'],
      customId: json['customId'],
      likesCount: json['likesCount'],
      shareCount: json['shareCount'],
      commentsCount: json['commentsCount'],
      likes: (json['likes'] as List?)
          ?.map((e) => Like.fromJson(e))
          .toList(),
      sharedUsers: (json['sharedUsers'] as List?)
          ?.map((e) => SharedUser.fromJson(e))
          .toList(),
      comments: (json['comments'] as List?)
          ?.map((e) => Comment.fromJson(e))
          .toList(),
      createdAt:
      json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
      json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
      isLikedByMe: json['isLikedByMe'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['content'] = this.content;
    data['specification'] = this.specification;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.toJson();
    }
    data['sharedBy'] = this.sharedBy;
    data['mainPost'] = this.mainPost;
    data['sharedFrom'] = this.sharedFrom;
    data['customId'] = this.customId;
    data['likesCount'] = this.likesCount;
    data['shareCount'] = this.shareCount;
    data['commentsCount'] = this.commentsCount;
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    if (this.sharedUsers != null) {
      data['sharedUsers'] = this.sharedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt?.toIso8601String();
    data['updatedAt'] = this.updatedAt?.toIso8601String();
    data['__v'] = this.v;
    data['isLikedByMe'] = this.isLikedByMe;
    return data;
  }
}

class Attachment {
  String? secureUrl;
  String? publicId;

  Attachment({this.secureUrl, this.publicId});

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secure_url'] = this.secureUrl;
    data['public_id'] = this.publicId;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? userName;
  String? role;
  ProfilePic? profilePic;

  CreatedBy({this.id, this.userName, this.role, this.profilePic});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'] != null ? ProfilePic.fromJson(json['profilePic']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['userName'] = this.userName;
    data['role'] = this.role;
    if (this.profilePic != null) {
      data['profilePic'] = this.profilePic!.toJson();
    }
    return data;
  }
}

class ProfilePic {
  String? secureUrl;
  String? publicId;

  ProfilePic({this.secureUrl, this.publicId});

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secure_url'] = this.secureUrl;
    data['public_id'] = this.publicId;
    return data;
  }
}

class Like {
  String? userId;
  String? id;

  Like({this.userId, this.id});

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      userId: json['userId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['_id'] = this.id;
    return data;
  }
}

class SharedUser {
  String? userId;
  String? id;

  SharedUser({this.userId, this.id});

  factory SharedUser.fromJson(Map<String, dynamic> json) {
    return SharedUser(
      userId: json['userId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['_id'] = this.id;
    return data;
  }
}

class Comment {
  String? userId;
  String? comment;
  String? id;

  Comment({this.userId, this.comment, this.id});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'],
      comment: json['comment'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['comment'] = this.comment;
    data['_id'] = this.id;
    return data;
  }
}

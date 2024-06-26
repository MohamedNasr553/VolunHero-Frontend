class SharePostResponse {
  String? message;
  Post? post;

  SharePostResponse({this.message, this.post});

  SharePostResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }
}

class Post {
  String? content;
  String? specification;
  List<Attachments>? attachments;
  User? createdBy;
  User? sharedBy;
  String? mainPost;
  String? sharedFrom;
  int? likesCount;
  int? shareCount;
  int? commentsCount;
  String? sId;
  List<SharedPostComments>? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Post({
    this.content,
    this.specification,
    this.attachments,
    this.createdBy,
    this.sharedBy,
    this.mainPost,
    this.sharedFrom,
    this.likesCount,
    this.shareCount,
    this.commentsCount,
    this.sId,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Post.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    specification = json['specification'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    createdBy = json['createdBy'] != null ? User.fromJson(json['createdBy']) : null;
    sharedBy = json['sharedBy'] != null ? User.fromJson(json['sharedBy']) : null;
    mainPost = json['mainPost'];
    sharedFrom = json['sharedFrom'];
    likesCount = json['likesCount'];
    shareCount = json['shareCount'];
    commentsCount = json['commentsCount'];
    sId = json['_id'];
    if (json['comments'] != null) {
      comments = <SharedPostComments>[];
      json['comments'].forEach((v) {
        comments!.add(SharedPostComments.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class Attachments {
  String? secureUrl;
  String? publicId;

  Attachments({this.secureUrl, this.publicId});

  Attachments.fromJson(Map<String, dynamic> json) {
    secureUrl = json['secure_url'];
    publicId = json['public_id'];
  }
}

class User {
  String? id;
  String? userName;
  String? role;
  String? profilePic;

  User({this.id, this.userName, this.role, this.profilePic});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userName = json['userName'];
    role = json['role'];
    profilePic = json['profilePic'];
  }
}

class SharedPostComments {
  String commentId;
  String id;

  SharedPostComments({
    required this.commentId,
    required this.id,
  });

  factory SharedPostComments.fromJson(Map<String, dynamic> json) {
    return SharedPostComments(
      commentId: json['commentId'],
      id: json['_id'],
    );
  }
}

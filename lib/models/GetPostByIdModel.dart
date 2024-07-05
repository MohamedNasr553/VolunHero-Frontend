class GetPostById {
  String? message;
  SpecificPost? post;

  GetPostById({this.message, this.post});

  GetPostById.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    post = json['post'] != null ? SpecificPost.fromJson(json['post']) : null;
  }
}

class SpecificPost {
  String? id;
  String? content;
  String? specification;
  List<Attachments>? attachments;
  CreatedBy createdBy;
  SharedBy? sharedBy;
  String? mainPost;
  String? sharedFrom;
  int? likesCount;
  int? shareCount;
  int? commentsCount;
  List<SharedUsers>? sharedUsers;
  List<Comments>? comments;
  DateTime createdAt;
  DateTime updatedAt;
  int? iV;
  bool? isLikedByMe;

  SpecificPost({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
    required this.createdBy,
    this.sharedBy,
    this.mainPost,
    this.sharedFrom,
    required this.likesCount,
    required this.commentsCount,
    required this.shareCount,
    required this.sharedUsers,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
    required this.isLikedByMe,
  });

  factory SpecificPost.fromJson(Map<String, dynamic> json) {
    var attachments = <Attachments>[];
    var sharedUsers = <SharedUsers>[];
    var comments = <Comments>[];

    if (json.containsKey('attachments') && json['attachments'] != null) {
      json['attachments'].forEach((element) {
        attachments.add(Attachments.fromJson(element));
      });
    }

    if (json.containsKey('sharedUsers') && json['sharedUsers'] != null) {
      json['sharedUsers'].forEach((element) {
        sharedUsers.add(SharedUsers.fromJson(element));
      });
    }

    if (json.containsKey('comments') && json['comments'] != null) {
      json['comments'].forEach((element) {
        comments.add(Comments.fromJson(element));
      });
    }

    return SpecificPost(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      createdBy: CreatedBy.fromJson(json['createdBy']),
      sharedBy:
          json['sharedBy'] != null ? SharedBy.fromJson(json['sharedBy']) : null,
      mainPost: json['mainPost'],
      sharedFrom: json['sharedFrom'],
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      shareCount: json['shareCount'],
      sharedUsers: sharedUsers,
      comments: comments,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      iV: json['__v'],
      isLikedByMe: json['isLikedByMe'],
    );
  }
}

class SharedUsers {
  String? userId;
  String? id;
  String? sharedAt;

  SharedUsers({this.userId, this.id, this.sharedAt});

  SharedUsers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['_id'];
    sharedAt = json['sharedAt'];
  }
}

class Attachments {
  String secure_url;
  String public_id;

  Attachments({required this.secure_url, required this.public_id});

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      secure_url: json['secure_url'],
      public_id: json['public_id'],
    );
  }
}

class Comments {
  String? commentId;
  String? id;

  Comments({this.commentId, this.id});

  Comments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    id = json['_id'];
  }
}

class ProfilePic {
  String secure_url;
  String public_id;

  ProfilePic({required this.secure_url, required this.public_id});

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      secure_url: json['secure_url'],
      public_id: json['public_id'],
    );
  }
}

class CreatedBy {
  String id;
  String userName;
  String role;
  ProfilePic? profilePic;

  CreatedBy(
      {required this.id,
      required this.userName,
      required this.role,
      this.profilePic});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'] != null
          ? ProfilePic.fromJson(json['profilePic'])
          : null,
    );
  }
}

class SharedBy {
  String id;
  String userName;
  String role;
  ProfilePic? profilePic;

  SharedBy(
      {required this.id,
      required this.userName,
      required this.role,
      this.profilePic});

  factory SharedBy.fromJson(Map<String, dynamic> json) {
    return SharedBy(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'] != null
          ? ProfilePic.fromJson(json['profilePic'])
          : null,
    );
  }
}

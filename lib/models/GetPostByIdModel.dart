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
  int? likesCount;
  int? shareCount;
  int? commentsCount;
  List<SharedUsers>? sharedUsers;
  List<Comments>? comments;
  DateTime createdAt;
  DateTime updatedAt;
  int? iV;

  SpecificPost({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
    required this.createdBy,
    required this.likesCount,
    required this.commentsCount,
    required this.shareCount,
    required this.sharedUsers,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
  });

  factory SpecificPost.fromJson(Map<String, dynamic> json) {
    var attachments = <Attachments>[];
    var sharedUsers = <SharedUsers>[];
    var comments = <Comments>[];

    // Check if the "attachments" key exists in the JSON data
    if (json.containsKey('attachments') && json['attachments'] != null) {
      json['attachments'].forEach((element) {
        attachments.add(Attachments.fromJson(element));
      });
    }

    // Check if the "sharedUsers" key exists in the JSON data
    if (json.containsKey('sharedUsers') && json['sharedUsers'] != null) {
      json['sharedUsers'].forEach((element) {
        sharedUsers.add(SharedUsers.fromJson(element));
      });
    }

    // Check if the "comments" key exists in the JSON data
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
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      shareCount: json['shareCount'],
      sharedUsers: sharedUsers,
      comments: comments,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      iV: json['__v'],
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

  ProfilePic({
    required this.secure_url,
    required this.public_id,
  });

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
        profilePic: json['profilePic'] != null ? ProfilePic.fromJson(json['profilePic']) : null,
    );
  }
}

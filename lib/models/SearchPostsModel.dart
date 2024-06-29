class SearchPostResponse {
  String? message;
  List<SearchPostDetails>? searchPost;

  SearchPostResponse({this.message, this.searchPost});

  factory SearchPostResponse.fromJson(Map<String, dynamic> json) {
    var searchPostsList = json['posts'] as List<dynamic>;
    List<SearchPostDetails> posts =
    searchPostsList.map((postJson) => SearchPostDetails.fromJson(postJson)).toList();

    return SearchPostResponse(
      message: json['message'],
      searchPost: posts,
    );
  }
}

class SearchPostDetails {
  String? id;
  String? content;
  String? specification;
  List<Attachment>? attachments;
  Creator createdBy;
  Sharer? sharedBy;
  String? mainPost;
  String? sharedFrom;
  int likesCount;
  int shareCount;
  int commentsCount;
  List<ShareUser>? sharedUsers;
  List<SearchPostComment>? comments;
  DateTime createdAt;
  DateTime updatedAt;
  int iV;

  SearchPostDetails({
    required this.id,
    required this.content,
    required this.specification,
    this.attachments,
    required this.createdBy,
    this.sharedBy,
    this.mainPost,
    this.sharedFrom,
    required this.likesCount,
    required this.shareCount,
    required this.commentsCount,
    required this.sharedUsers,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
  });

  factory SearchPostDetails.fromJson(Map<String, dynamic> json) {
    var attachments = <Attachment>[];
    var sharedUsers = <ShareUser>[];
    var comments = <SearchPostComment>[];

    if (json.containsKey('attachments') && json['attachments'] != null) {
      json['attachments'].forEach((element) {
        attachments.add(Attachment.fromJson(element));
      });
    }

    if (json.containsKey('sharedUsers') && json['sharedUsers'] != null) {
      json['sharedUsers'].forEach((element) {
        sharedUsers.add(ShareUser.fromJson(element));
      });
    }

    if (json.containsKey('comments') && json['comments'] != null) {
      json['comments'].forEach((element) {
        comments.add(SearchPostComment.fromJson(element));
      });
    }

    return SearchPostDetails(
      id: json['_id'],
      content: json['content'],
      specification: json['specification'],
      attachments: attachments,
      createdBy: Creator.fromJson(json['createdBy']),
      sharedBy:
      json['sharedBy'] != null ? Sharer.fromJson(json['sharedBy']) : null,
      mainPost: json['mainPost'],
      sharedFrom: json['sharedFrom'],
      likesCount: json['likesCount'],
      shareCount: json['shareCount'],
      commentsCount: json['commentsCount'],
      sharedUsers: sharedUsers,
      comments: comments,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      iV: json['__v'],
    );
  }
}

class ShareUser {
  String? userId;
  String? id;
  String? sharedAt;

  ShareUser({this.userId, this.id, this.sharedAt});

  ShareUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['_id'];
    sharedAt = json['sharedAt'];
  }
}

class Attachment {
  String secureUrl;
  String publicId;

  Attachment({required this.secureUrl, required this.publicId});

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}

class SearchPostComment {
  String? commentId;
  String? id;

  SearchPostComment({this.commentId, this.id});

  SearchPostComment.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    id = json['_id'];
  }
}

class ProfilePicture {
  String secureUrl;
  String publicId;

  ProfilePicture({required this.secureUrl, required this.publicId});

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return ProfilePicture(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}

class Creator {
  String id;
  String userName;
  String role;
  ProfilePicture? profilePic;

  Creator({
    required this.id,
    required this.userName,
    required this.role,
    this.profilePic,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'] != null
          ? ProfilePicture.fromJson(json['profilePic'])
          : null,
    );
  }
}

class Sharer {
  String id;
  String userName;
  String role;
  ProfilePicture? profilePic;

  Sharer({
    required this.id,
    required this.userName,
    required this.role,
    this.profilePic,
  });

  factory Sharer.fromJson(Map<String, dynamic> json) {
    return Sharer(
      id: json['_id'],
      userName: json['userName'],
      role: json['role'],
      profilePic: json['profilePic'] != null
          ? ProfilePicture.fromJson(json['profilePic'])
          : null,
    );
  }
}

class OtherUserProfile {
  final String message;
  final List<OtherUserFollowingsModel>? otherUserFollowingsList;

  OtherUserProfile({required this.message, this.otherUserFollowingsList});

  factory OtherUserProfile.fromJson(Map<String, dynamic> json) {
    return OtherUserProfile(
      message: json['message'] as String,
      otherUserFollowingsList: json['followings'] != null
          ? List<OtherUserFollowingsModel>.from(json['followings']
              .map((item) => OtherUserFollowingsModel.fromJson(item)))
          : null,
    );
  }
}

class OtherUserFollowingsModel {
  final OtherUserId userId;
  final String id;

  OtherUserFollowingsModel({required this.userId, required this.id});

  factory OtherUserFollowingsModel.fromJson(Map<String, dynamic> json) {
    return OtherUserFollowingsModel(
      userId: OtherUserId.fromJson(json['userId'] as Map<String, dynamic>),
      id: json['_id'] as String,
    );
  }
}

class OtherUserId {
  final String id;
  final String userName;
  final ProfilePic? profilePic;

  OtherUserId({required this.id, required this.userName, this.profilePic});

  factory OtherUserId.fromJson(Map<String, dynamic> json) {
    return OtherUserId(
      id: json['_id'] as String,
      userName: json['userName'] as String,
      profilePic: json['profilePic'] != null
          ? ProfilePic.fromJson(json['profilePic'])
          : null,
    );
  }
}

class ProfilePic {
  final String secureUrl;
  final String publicId;

  ProfilePic({required this.secureUrl, required this.publicId});

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}

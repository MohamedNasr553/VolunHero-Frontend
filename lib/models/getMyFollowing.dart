class UserProfile {
  final String message;
  final List<MyFollowings> followingsList;

  UserProfile({required this.message, required this.followingsList});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var followingsList = json['followings'] as List;
    List<MyFollowings> followings =
        followingsList.map((e) => MyFollowings.fromJson(e)).toList();

    return UserProfile(
      message: json['message'],
      followingsList: followings,
    );
  }
}

class MyFollowings {
  final UserId userId;
  final String id;

  MyFollowings({required this.userId, required this.id});

  factory MyFollowings.fromJson(Map<String, dynamic> json) {
    return MyFollowings(
      userId: UserId.fromJson(json['userId']),
      id: json['_id'],
    );
  }
}

class UserId {
  final String id;
  final String userName;
  final ProfilePic profilePic;

  UserId({required this.id, required this.userName, required this.profilePic});

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'],
      userName: json['userName'],
      profilePic: ProfilePic.fromJson(json['profilePic']),
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

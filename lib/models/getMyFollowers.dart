class GetMyFollowerResponse {
  final String message;
  final List<Follower> followersList;

  GetMyFollowerResponse({required this.message, required this.followersList});

  factory GetMyFollowerResponse.fromJson(Map<String, dynamic> json) {
    return GetMyFollowerResponse(
      message: json['message'],
      followersList: (json['followers'] as List)
          .map((followerJson) => Follower.fromJson(followerJson))
          .toList(),
    );
  }
}

class Follower {
  final FollowerUserId userId;
  final String id;

  Follower({required this.userId, required this.id});

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      userId: FollowerUserId.fromJson(json['userId']),
      id: json['_id'],
    );
  }
}

class FollowerUserId {
  final String id;
  final String userName;
  final ProfilePic? profilePic;

  FollowerUserId({required this.id, required this.userName, this.profilePic});

  factory FollowerUserId.fromJson(Map<String, dynamic> json) {
    return FollowerUserId(
      id: json['_id'],
      userName: json['userName'],
      profilePic: json['profilePic'] != null ? ProfilePic.fromJson(json['profilePic']) : null,
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







class UserLikesModel {
  String message;
  List<LikedUser> users;

  UserLikesModel({required this.message, required this.users});

  factory UserLikesModel.fromJson(Map<String, dynamic> json) {
    return UserLikesModel(
      message: json['message'],
      users:
          List<LikedUser>.from(json['users'].map((x) => LikedUser.fromJson(x))),
    );
  }
}

class LikedUser {
  String id;
  String firstName;
  String lastName;
  String userName;
  String slugUserName;
  String email;
  String phone;
  String role;
  ProfilePic? profilePic;
  dynamic coverPic;
  List<dynamic> images;
  String? dob;
  String address;
  String gender;
  String? overview;
  String? website;
  String? headquarters;
  String? specialties;
  List<dynamic> locations;
  String specification;
  List<dynamic> attachments;
  List<Following> following;
  List<Following> followers;
  String updatedAt;
  int version;

  LikedUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.slugUserName,
    required this.email,
    required this.phone,
    required this.role,
    this.profilePic,
    this.coverPic,
    required this.images,
    this.dob,
    required this.address,
    required this.gender,
    this.overview,
    this.website,
    this.headquarters,
    this.specialties,
    required this.locations,
    required this.specification,
    required this.attachments,
    required this.following,
    required this.followers,
    required this.updatedAt,
    required this.version,
  });

  factory LikedUser.fromJson(Map<String, dynamic> json) {
    return LikedUser(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      slugUserName: json['slugUserName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      profilePic: json['profilePic'] != null
          ? ProfilePic.fromJson(json['profilePic'])
          : null,
      coverPic: json['coverPic'],
      images: List<dynamic>.from(json['images']),
      dob: json['DOB'],
      address: json['address'],
      gender: json['gender'],
      overview: json['overview'],
      website: json['website'],
      headquarters: json['headquarters'],
      specialties: json['specialties'],
      locations: List<dynamic>.from(json['locations']),
      specification: json['specification'],
      attachments: List<dynamic>.from(json['attachments']),
      following: List<Following>.from(
          json['following'].map((x) => Following.fromJson(x))),
      followers: List<Following>.from(
          json['followers'].map((x) => Following.fromJson(x))),
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }
}

class ProfilePic {
  String secureUrl;
  String publicId;

  ProfilePic({required this.secureUrl, required this.publicId});

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}

class Following {
  String userId;
  String id;

  Following({required this.userId, required this.id});

  factory Following.fromJson(Map<String, dynamic> json) {
    return Following(
      userId: json['userId'],
      id: json['_id'],
    );
  }
}

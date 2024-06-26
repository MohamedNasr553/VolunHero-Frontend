class LoggedInUserModel {
  final String message;
  final LoggedInUserData data;

  LoggedInUserModel({required this.message, required this.data});

  factory LoggedInUserModel.fromJson(Map<String, dynamic> json) {
    return LoggedInUserModel(
      message: json['message'],
      data: LoggedInUserData.fromJson(json['data']),
    );
  }
}

class LoggedInUserData {
  final LoggedInUser doc;

  LoggedInUserData({required this.doc});

  factory LoggedInUserData.fromJson(Map<String, dynamic> json) {
    return LoggedInUserData(
      doc: LoggedInUser.fromJson(json['doc']),
    );
  }
}

class LoggedInUser {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String slugUserName;
  final String email;
  final String phone;
  final String role;
  final ProfilePic? profilePic;
  final String? coverPic;
  final List<String> images;
  final String address;
  final String gender;
  final String? headquarters;
  final String? specialties;
  final List<String>? locations;
  final String specification;
  final List<dynamic> attachments;
  final List<dynamic> following;
  final List<Map<String, dynamic>> followers;
  final String updatedAt;
  final int v;

  LoggedInUser({
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
    required this.address,
    required this.gender,
    required this.headquarters,
    this.specialties,
    this.locations,
    required this.specification,
    required this.attachments,
    required this.following,
    required this.followers,
    required this.updatedAt,
    required this.v,
  });

  factory LoggedInUser.fromJson(Map<String, dynamic> json) {
    return LoggedInUser(
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
      images: List<String>.from(json['images']),
      address: json['address'],
      gender: json['gender'],
      headquarters: json['headquarters'],
      specialties: json['specialties'],
      locations: List<String>.from(json['locations']),
      specification: json['specification'],
      attachments: List<dynamic>.from(json['attachments']),
      following: List<dynamic>.from(json['following']),
      followers: List<Map<String, dynamic>>.from(json['followers']),
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
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

  @override
  String toString() {
    return 'ProfilePic: {secureUrl: $secure_url, publicId: $public_id}';
  }
}

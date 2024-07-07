class AnotherUser {
  late final String id;
  final String firstName;
  final String lastName;
  late final String userName;
  final String slugUserName;
  final String email;
  final String phone;
  final String role;
  final String status;
  final ProfilePic? profilePic;
  final CoverPic? coverPic;
  final List<String> images;
  final String? DOB;
  final String address;
  final String gender;
  final String? overview;
  final String? website;
  final String? headquarters;
  final String? specialties;
  final List<dynamic> locations;
  final String specification;
  final List<Attachment> attachments;
  final List<Following> following;
  final List<Followers> followers;
  final String updatedAt;
  late bool isFollowed;

  AnotherUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.slugUserName,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    this.profilePic,
    this.coverPic,
    required this.images,
    this.DOB,
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
  });

  factory AnotherUser.fromJson(Map<String, dynamic> json) {
    return AnotherUser(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      slugUserName: json['slugUserName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      status: json['status'],
      profilePic: json['profilePic'] != null ? ProfilePic.fromJson(json['profilePic']) : null,
      coverPic: json['coverPic'] != null ? CoverPic.fromJson(json['coverPic']) : null,
      images: List<String>.from(json['images']),
      DOB: json['DOB'],
      address: json['address'],
      gender: json['gender'],
      overview: json['overview'],
      website: json['website'],
      headquarters: json['headquarters'],
      specialties: json['specialties'],
      locations: List<dynamic>.from(json['locations']),
      specification: json['specification'],
      attachments: (json['attachments'] as List).map((item) => Attachment.fromJson(item)).toList(),
      following: (json['following'] as List).map((item) => Following.fromJson(item)).toList(),
      followers: (json['followers'] as List).map((item) => Followers.fromJson(item)).toList(),
      updatedAt: json['updatedAt'],
    );
  }

  @override
  String toString() {
    return 'AnotherUser(id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, slugUserName: $slugUserName, email: $email, phone: $phone, role: $role, status: $status, profilePic: $profilePic, coverPic: $coverPic, images: $images, DOB: $DOB, address: $address, gender: $gender, overview: $overview, website: $website, headquarters: $headquarters, specialties: $specialties, locations: $locations, specification: $specification, attachments: $attachments, following: $following, followers: $followers, updatedAt: $updatedAt)';
  }
}

class ProfilePic {
  final String secureUrl;
  final String publicId;

  ProfilePic({
    required this.secureUrl,
    required this.publicId,
  });

  factory ProfilePic.fromJson(Map<String, dynamic> json) {
    return ProfilePic(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}

class CoverPic {
  final String secureUrl;
  final String publicId;

  CoverPic({
    required this.secureUrl,
    required this.publicId,
  });

  factory CoverPic.fromJson(Map<String, dynamic> json) {
    return CoverPic(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}

class Attachment {
  final String secureUrl;
  final String publicId;

  Attachment({
    required this.secureUrl,
    required this.publicId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      secureUrl: json['secure_url'],
      publicId: json['public_id'],
    );
  }
}

class Following {
  final String userId;
  final String id;

  Following({
    required this.userId,
    required this.id,
  });

  factory Following.fromJson(Map<String, dynamic> json) {
    return Following(
      userId: json['userId'],
      id: json['_id'],
    );
  }
}

class Followers {
  final String userId;
  final String id;

  Followers({
    required this.userId,
    required this.id,
  });

  factory Followers.fromJson(Map<String, dynamic> json) {
    return Followers(
      userId: json['userId'],
      id: json['_id'],
    );
  }
}
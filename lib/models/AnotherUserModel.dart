class AnotherUser {
  late  String id;
  final String firstName;
  final String lastName;
  late  String userName;
  final String slugUserName;
  final String email;
  final String phone;
  final String role;
  final String? profilePic;
  final String? coverPic;
  final List<String> images;
  final String DOB;
  final String address;
  final String gender;
  final List<dynamic> locations;
  final String specification;
  final List<dynamic> attachments;
  final List<dynamic> following;
  final List<dynamic> followers;
  final String updatedAt;
  late bool isFollowed = false;

  AnotherUser({
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
    required this.DOB,
    required this.address,
    required this.gender,
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
      profilePic: json['profilePic'],
      coverPic: json['coverPic'],
      images: List<String>.from(json['images']),
      DOB: json['DOB'],
      address: json['address'],
      gender: json['gender'],
      locations: List<dynamic>.from(json['locations']),
      specification: json['specification'],
      attachments: List<dynamic>.from(json['attachments']),
      following: List<dynamic>.from(json['following']),
      followers: List<dynamic>.from(json['followers']),
      updatedAt: json['updatedAt'],
    );
  }

  @override
  String toString() {
    return 'AnotherUser(id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, slugUserName: $slugUserName, email: $email, phone: $phone, role: $role, profilePic: $profilePic, coverPic: $coverPic, images: $images, DOB: $DOB, address: $address, gender: $gender, locations: $locations, specification: $specification, attachments: $attachments, following: $following, followers: $followers, updatedAt: $updatedAt)';
  }
}

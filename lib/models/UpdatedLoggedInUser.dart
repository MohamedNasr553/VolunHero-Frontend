class UpdatedLoggedInUser {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phone;
  final String role;
  final String status;
  final bool confirmEmail;
  final List<String> images;
  final String dob;
  final String address;
  final String gender;
  final List<String> locations;
  final String specification;
  final List<String> attachments;
  final List<String> following;
  final List<String> followers;
  final DateTime createdAt;
  final DateTime updatedAt;

  UpdatedLoggedInUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    required this.confirmEmail,
    required this.images,
    required this.dob,
    required this.address,
    required this.gender,
    required this.locations,
    required this.specification,
    required this.attachments,
    required this.following,
    required this.followers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdatedLoggedInUser.fromJson(Map<String, dynamic> json) {
    return UpdatedLoggedInUser(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      status: json['status'],
      confirmEmail: json['confirmEmail'],
      images: List<String>.from(json['images']),
      dob: json['DOB'],
      address: json['address'],
      gender: json['gender'],
      locations: List<String>.from(json['locations']),
      specification: json['specification'],
      attachments: List<String>.from(json['attachments']),
      following: List<String>.from(json['following']),
      followers: List<String>.from(json['followers']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'UpdatedLoggedInUser{id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, phone: $phone, role: $role, status: $status, confirmEmail: $confirmEmail, images: $images, dob: $dob, address: $address, gender: $gender, locations: $locations, specification: $specification, attachments: $attachments, following: $following, followers: $followers, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

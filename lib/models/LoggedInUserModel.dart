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
  final String password;
  final String phone;
  final String role;
  final String status;
  final bool confirmEmail;
  final List<String> images;
  final String dob;
  final String address;
  final String gender;
  final dynamic forgetCode;
  final dynamic changePasswordTime;
  final List<String> locations;
  final String specification;
  final List<dynamic> attachments;
  final List<dynamic> following;
  final List<dynamic> followers;
  final String createdAt;
  final String updatedAt;
  final int v;

  LoggedInUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.slugUserName,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.status,
    required this.confirmEmail,
    required this.images,
    required this.dob,
    required this.address,
    required this.gender,
    required this.forgetCode,
    required this.changePasswordTime,
    required this.locations,
    required this.specification,
    required this.attachments,
    required this.following,
    required this.followers,
    required this.createdAt,
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
      password: json['password'],
      phone: json['phone'],
      role: json['role'],
      status: json['status'],
      confirmEmail: json['confirmEmail'],
      images: List<String>.from(json['images']),
      dob: json['DOB'],
      address: json['address'],
      gender: json['gender'],
      forgetCode: json['forgetCode'],
      changePasswordTime: json['changePasswordTime'],
      locations: List<String>.from(json['locations']),
      specification: json['specification'],
      attachments: List<dynamic>.from(json['attachments']),
      following: List<dynamic>.from(json['following']),
      followers: List<dynamic>.from(json['followers']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  @override
  String toString() {
    return 'LoggedInUser{id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, slugUserName: $slugUserName, email: $email, phone: $phone, role: $role, status: $status, confirmEmail: $confirmEmail, images: $images, dob: $dob, address: $address, gender: $gender, locations: $locations, specification: $specification, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

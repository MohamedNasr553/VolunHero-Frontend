class SupportCallsUserModel {
  final String message;
  final List<SupportCallsUserDetails> users;

  SupportCallsUserModel({
    required this.message,
    required this.users,
  });

  factory SupportCallsUserModel.fromJson(Map<String, dynamic> json) {
    var usersFromJson = json['users'] as List;
    List<SupportCallsUserDetails> userList = usersFromJson
        .map((userJson) => SupportCallsUserDetails.fromJson(userJson))
        .toList();

    return SupportCallsUserModel(
      message: json['message'],
      users: userList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'users': users.map((user) => user.toJson()).toList(),
    };
  }
}

class SupportCallsUserDetails {
  final String id;
  final String userName;
  final String phone;
  final String role;
  final String status;
  final ProfilePic? profilePic;
  final String specification;

  SupportCallsUserDetails({
    required this.id,
    required this.userName,
    required this.phone,
    required this.role,
    required this.status,
    this.profilePic,
    required this.specification,
  });

  factory SupportCallsUserDetails.fromJson(Map<String, dynamic> json) {
    return SupportCallsUserDetails(
      id: json['_id'],
      userName: json['userName'],
      phone: json['phone'],
      role: json['role'],
      status: json['status'],
      profilePic: json['profilePic'] != null
          ? ProfilePic.fromJson(json['profilePic'])
          : null,
      specification: json['specification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'phone': phone,
      'role': role,
      'status': status,
      'profilePic': profilePic?.toJson(),
      'specification': specification,
    };
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
      secureUrl: json['secure_url'] ?? '',
      publicId: json['public_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secureUrl,
      'public_id': publicId,
    };
  }
}

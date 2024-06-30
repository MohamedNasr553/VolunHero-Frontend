class UpdatePassword {
  String? status;
  UserInfo? userInfo;

  UpdatePassword({this.status, this.userInfo});

  UpdatePassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userInfo = json['user'] != null ? UserInfo.fromJson(json['user']) : null;
  }
}

class UserInfo {
  String? sId;
  String? firstName;
  String? lastName;
  String? userName;
  String? slugUserName;
  String? email;
  String? password;
  String? phone;
  String? role;
  String? status;
  bool? confirmEmail;
  String? dOB;
  String? address;
  String? gender;
  String? changePasswordTime;
  String? specification;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Following>? following;
  List<Follower>? followers;

  UserInfo(
      {this.sId,
        this.firstName,
        this.lastName,
        this.userName,
        this.slugUserName,
        this.email,
        this.password,
        this.phone,
        this.role,
        this.status,
        this.confirmEmail,
        this.dOB,
        this.address,
        this.gender,
        this.changePasswordTime,
        this.specification,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.following,
        this.followers});

  UserInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    slugUserName = json['slugUserName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    status = json['status'];
    confirmEmail = json['confirmEmail'];
    dOB = json['DOB'];
    address = json['address'];
    gender = json['gender'];
    changePasswordTime = json['changePasswordTime'];
    specification = json['specification'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['following'] != null) {
      following = <Following>[];
      json['following'].forEach((v) {
        following!.add(Following.fromJson(v));
      });
    }
    if (json['followers'] != null) {
      followers = <Follower>[];
      json['followers'].forEach((v) {
        followers!.add(Follower.fromJson(v));
      });
    }
  }
}

class Following {
  String? userId;
  String? sId;

  Following({this.userId, this.sId});

  Following.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    sId = json['_id'];
  }
}

class Follower {
  String? userId;
  String? sId;

  Follower({this.userId, this.sId});

  Follower.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    sId = json['_id'];
  }
}

class SignupModel {
  String? message;
  NewUser? newUser;

  SignupModel({this.message, this.newUser});

  SignupModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    newUser =
    json['newUser'] != null ? NewUser.fromJson(json['newUser']) : null;
  }
}

class NewUser {
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  String? phone;
  String? role;
  String? status;
  bool? confirmEmail;
  String? dOB;
  String? address;
  String? gender;
  List<String>? locations;
  String? specification;
  ProfilePic? profilePic;
  CoverPic? coverPic;
  List<Attachments>? attachments;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NewUser.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    status = json['status'];
    confirmEmail = json['confirmEmail'];
    dOB = json['DOB'];
    address = json['address'];
    gender = json['gender'];
    specification = json['specification'];
    profilePic = ProfilePic.fromJson(json['profilePic']);
    coverPic = CoverPic.fromJson(json['coverPic']);
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class Attachments {
  String? secureUrl;
  String? publicId;

  Attachments.fromJson(Map<String, dynamic> json) {
    secureUrl = json['secure_url'];
    publicId = json['public_id'];
  }
}

class ProfilePic {
  String? secureUrl;
  String? publicId;

  ProfilePic.fromJson(Map<String, dynamic> json) {
    secureUrl = json['secure_url'];
    publicId = json['public_id'];
  }
}

class CoverPic {
  String? secureUrl;
  String? publicId;

  CoverPic.fromJson(Map<String, dynamic> json) {
    secureUrl = json['secure_url'];
    publicId = json['public_id'];
  }
}
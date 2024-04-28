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
  List<Null>? images;
  String? dOB;
  String? address;
  String? gender;
  Null? forgetCode;
  Null? changePasswordTime;
  List<Null>? locations;
  String? specification;
  List<Attachments>? attachments;
  String? sId;
  List<Null>? following;
  List<Null>? followers;
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
    // if (json['images'] != null) {
    //   images = <Null>[];
    //   json['images'].forEach((v) {
    //     images!.add(Null.fromJson(v));
    //   });
    // }
    dOB = json['DOB'];
    address = json['address'];
    gender = json['gender'];
    forgetCode = json['forgetCode'];
    changePasswordTime = json['changePasswordTime'];
    // if (json['locations'] != null) {
    //   locations = <Null>[];
    //   json['locations'].forEach((v) {
    //     locations!.add(Null.fromJson(v));
    //   });
    // }
    specification = json['specification'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    sId = json['_id'];
    // if (json['following'] != null) {
    //   following = <Null>[];
    //   json['following'].forEach((v) {
    //     following!.add(Null.fromJson(v));
    //   });
    // }

    // if (json['followers'] != null) {
    //   followers = <Null>[];
    //   json['followers'].forEach((v) {
    //     followers!.add(Null.fromJson(v));
    //   });
    // }
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

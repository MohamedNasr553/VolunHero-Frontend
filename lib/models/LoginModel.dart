class LoginModel{
  String? message;
  String? access_token;
  String? refresh_token;

  LoginModel({this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    access_token = json['access_token'];
    refresh_token = json['refresh_token'];
  }
}
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
//{_id: 662e2849c4ed7f0e0e58eff6, role: User, iat: 1714329692, exp: 1714331492}
class DecodedToken {
  String? id;
  String? role;
  int? iat;
  int? exp;

  DecodedToken({
    this.id,
    this.role,
    this.iat,
    this.exp,
  });

  factory DecodedToken.fromMap(Map<String, dynamic> map) {
    return DecodedToken(
      id: map['_id'],
      role: map['role'],
      iat: map['iat'],
      exp: map['exp'],
    );
  }
}
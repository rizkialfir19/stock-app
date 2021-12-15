import 'package:stock_app/common/common.dart';

class User extends BaseModel {
  final String? token;
  final String? email;
  final String? username;
  final String? fullName;
  final String? accessToken;

  User({
    this.token,
    this.email,
    this.username,
    this.fullName,
    this.accessToken,
  }) : super({
          "token": token,
          "email": email,
          "username": username,
          "fullName": fullName,
          "accessToken": accessToken,
        });

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Null JSON provided');
    }

    return User(
      token: json['token'],
      email: json['email'],
      username: json['username'],
      fullName: json['fullName'],
      accessToken: json['accessToken'],
    );
  }

  @override
  copyWith({
    String? token,
    String? email,
    String? username,
    String? fullName,
    String? accessToken,
  }) {
    return User(
      token: token ?? this.token,
      email: email ?? this.email,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

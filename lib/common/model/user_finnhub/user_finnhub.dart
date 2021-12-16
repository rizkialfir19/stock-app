import 'package:stock_app/common/common.dart';

class UserFinnhub extends BaseModel {
  final String? email;
  final String? username;
  final String? fullName;
  final String? imageUrl;
  final String? uid;
  final String? accessToken;
  final String? lastSignIn;

  UserFinnhub({
    this.email,
    this.username,
    this.fullName,
    this.imageUrl,
    this.uid,
    this.accessToken,
    this.lastSignIn,
  }) : super({
          "email": email,
          "username": username,
          "fullName": fullName,
          "imageUrl": imageUrl,
          "uid": uid,
          "accessToken": accessToken,
          "lastSignIn": lastSignIn,
        });

  factory UserFinnhub.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException('Null JSON provided');
    }

    return UserFinnhub(
      email: json['email'],
      username: json['username'],
      fullName: json['fullName'],
      imageUrl: json['imageUrl'],
      uid: json['uid'],
      accessToken: json['accessToken'],
      lastSignIn: json['lastSignIn'],
    );
  }

  @override
  copyWith({
    String? email,
    String? username,
    String? fullName,
    String? imageUrl,
    String? uid,
    String? accessToken,
    String? lastSignIn,
  }) {
    return UserFinnhub(
      email: email ?? this.email,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      imageUrl: imageUrl ?? this.imageUrl,
      uid: uid ?? this.uid,
      accessToken: accessToken ?? this.accessToken,
      lastSignIn: lastSignIn ?? this.lastSignIn,
    );
  }
}

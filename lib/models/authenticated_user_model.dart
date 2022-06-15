import 'package:equatable/equatable.dart';

class AuthenticatedUserModel extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String avatar;

  const AuthenticatedUserModel({
    required this.uid,
    required this.username,
    required this.email,
    this.avatar = "",
  });

  factory AuthenticatedUserModel.fromMap(Map<String, dynamic> user) {
    return AuthenticatedUserModel(
      uid: user['uid'],
      username: user['username'],
      email: user['email'],
      avatar: user['avatar'],
    );
  }

  toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'avatar': avatar,
    };
  }

  bool get isEmpty => uid.isEmpty;

  factory AuthenticatedUserModel.empty() {
    return const AuthenticatedUserModel(
      uid: '',
      username: '',
      email: '',
      avatar: '',
    );
  }

  @override
  List<Object?> get props => [
        uid,
        username,
        email,
        avatar,
      ];
}

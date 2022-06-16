import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String uid;
  final String username;
  final String avatar;
  final String description;

  const ProfileModel({
    required this.uid,
    required this.avatar,
    required this.username,
    required this.description,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> data) => ProfileModel(
        uid: data['uid'] ?? "",
        avatar: data['avatar'] ?? "",
        username: data['username'] ?? "",
        description: data['description'] ?? "",
      );

  factory ProfileModel.empty() => const ProfileModel(
        uid: "",
        avatar: "",
        username: "",
        description: "",
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'avatar': avatar,
        'username': username,
        'description': description,
      };

  @override
  List<Object> get props => [
        uid,
        avatar,
        username,
        description,
      ];
}

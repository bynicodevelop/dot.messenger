import 'package:dot_messenger/models/profile_model.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final ProfileModel profile;
  final String authenticatedUserId;
  final String peerId;
  final String lastMessage;
  final DateTime updatedAt;

  const ChatModel({
    required this.profile,
    required this.authenticatedUserId,
    required this.peerId,
    required this.lastMessage,
    required this.updatedAt,
  });

  String get id => authenticatedUserId.hashCode <= peerId.hashCode
      ? "${authenticatedUserId}_$peerId"
      : "${peerId}_$authenticatedUserId";

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      profile: json['profile'],
      authenticatedUserId: json['authenticatedUserId'],
      peerId: json['peerId'],
      lastMessage: json['lastMessage'],
      updatedAt: json['updatedAt'],
    );
  }

  @override
  List<Object> get props => [
        id,
        profile,
        authenticatedUserId,
        peerId,
        lastMessage,
        updatedAt,
      ];
}

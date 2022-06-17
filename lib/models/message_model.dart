import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String id;
  final String chatId;
  final String author;
  final String message;
  final DateTime time;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.author,
    required this.message,
    required this.time,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      author: json['author'] as String,
      message: json['message'] as String,
      time: json['time'],
    );
  }

  @override
  List<Object> get props => [
        id,
        chatId,
        author,
        message,
        time,
      ];
}

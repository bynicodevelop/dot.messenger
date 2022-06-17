part of 'post_message_bloc.dart';

abstract class PostMessageEvent extends Equatable {
  const PostMessageEvent();

  @override
  List<Object> get props => [];
}

class OnSendMessageEvent extends PostMessageEvent {
  final ChatModel chatModel;
  final String message;

  const OnSendMessageEvent({
    required this.chatModel,
    required this.message,
  });

  @override
  List<Object> get props => [
        chatModel,
        message,
      ];
}

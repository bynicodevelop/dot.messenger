part of 'list_chat_bloc.dart';

abstract class ListChatEvent extends Equatable {
  const ListChatEvent();

  @override
  List<Object> get props => [];
}

class OnListChatEvent extends ListChatEvent {}

class OnLoaderMessageEvent extends ListChatEvent {
  final List<ChatModel> chatModel;

  const OnLoaderMessageEvent({
    required this.chatModel,
  });

  @override
  List<Object> get props => [
        chatModel,
      ];
}

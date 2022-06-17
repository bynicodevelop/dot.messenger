part of 'list_chat_bloc.dart';

abstract class ListChatState extends Equatable {
  const ListChatState();

  @override
  List<Object> get props => [];
}

class ListChatInitialState extends ListChatState {
  final List<ChatModel> chatModel;

  const ListChatInitialState({
    this.chatModel = const [],
  });

  @override
  List<Object> get props => [
        chatModel,
      ];
}

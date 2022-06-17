part of 'list_message_bloc.dart';

abstract class ListMessageEvent extends Equatable {
  const ListMessageEvent();

  @override
  List<Object> get props => [];
}

class OnLoadListMessage extends ListMessageEvent {
  final ChatModel chatModel;

  const OnLoadListMessage({
    required this.chatModel,
  });

  @override
  List<Object> get props => [
        chatModel,
      ];
}

class OnLoadedListMessage extends ListMessageEvent {
  final List<MessageModel> messages;

  const OnLoadedListMessage({
    required this.messages,
  });

  @override
  List<Object> get props => [
        messages,
      ];
}

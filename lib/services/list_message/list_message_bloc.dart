import 'package:bloc/bloc.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/models/message_model.dart';
import 'package:dot_messenger/repositories/message_repository.dart';
import 'package:equatable/equatable.dart';

part 'list_message_event.dart';
part 'list_message_state.dart';

class ListMessageBloc extends Bloc<ListMessageEvent, ListMessageState> {
  final MessageRepository messageRepository;

  ListMessageBloc({
    required this.messageRepository,
  }) : super(const ListMessageInitialState()) {
    messageRepository.messages.listen((List<MessageModel> messages) {
      add(OnLoadedListMessage(
        messages: messages,
      ));
    });

    on<OnLoadListMessage>((event, emit) async {
      await messageRepository.loadMessages({
        "chatId": event.chatModel.id,
      });
    });

    on<OnLoadedListMessage>((event, emit) {
      emit(ListMessageInitialState(
        messages: event.messages,
      ));
    });
  }
}

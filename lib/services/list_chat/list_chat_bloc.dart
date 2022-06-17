import 'package:bloc/bloc.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'list_chat_event.dart';
part 'list_chat_state.dart';

class ListChatBloc extends Bloc<ListChatEvent, ListChatState> {
  final ChatRepository chatRepository;

  ListChatBloc({
    required this.chatRepository,
  }) : super(const ListChatInitialState()) {
    chatRepository.chats.listen((List<ChatModel> chatModel) {
      add(OnLoaderMessageEvent(
        chatModel: chatModel,
      ));
    });

    on<OnListChatEvent>((event, emit) async {
      await chatRepository.loadChats();
    });

    on<OnLoaderMessageEvent>((event, emit) async {
      emit(ListChatInitialState(
        chatModel: event.chatModel,
      ));
    });
  }
}

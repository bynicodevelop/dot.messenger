import 'package:bloc/bloc.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/repositories/message_repository.dart';
import 'package:equatable/equatable.dart';

part 'post_message_event.dart';
part 'post_message_state.dart';

class PostMessageBloc extends Bloc<PostMessageEvent, PostMessageState> {
  final MessageRepository messageRepository;

  PostMessageBloc({
    required this.messageRepository,
  }) : super(PostMessageInitialState()) {
    on<OnSendMessageEvent>((event, emit) async {
      emit(PostMessageLoadingState());

      await messageRepository.postMessage({
        'text': event.message,
        'chatModel': event.chatModel,
      });

      emit(PostMessageLoadedState(
        message: event.message,
      ));
    });
  }
}

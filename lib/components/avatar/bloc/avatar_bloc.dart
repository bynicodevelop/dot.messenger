import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  AvatarBloc() : super(const AvatarInitialState()) {
    on<OnAvatarUpdatedEvent>((event, emit) {
      emit(AvatarInitialState(
        avatar: event.avatar,
      ));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final UserRepository userRepository;

  LogoutBloc({
    required this.userRepository,
  }) : super(LogoutInitialState()) {
    on<OnLogoutEvent>((event, emit) async {
      emit(LogoutLoadingState());

      await userRepository.logout();

      emit(LogoutSuccessState());
    });
  }
}

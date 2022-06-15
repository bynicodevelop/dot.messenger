import 'package:bloc/bloc.dart';
import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({
    required this.userRepository,
  }) : super(
          AuthenticationInitialState(
            user: AuthenticatedUserModel.empty(),
          ),
        ) {
    userRepository.user.listen((user) {
      if (user.isEmpty) {
        add(OnUserUnAuthenticatedEvent());
      } else {
        add(OnUserAuthenticatedEvent(
          user: user,
        ));
      }
    });

    on<OnUserAuthenticatedEvent>((event, emit) {
      emit(AuthenticationInitialState(
        isReady: true,
        isAuthenticated: true,
        user: event.user,
        startWithWizard: event.user.username.isEmpty,
      ));
    });

    on<OnUserUnAuthenticatedEvent>((event, emit) {
      emit(AuthenticationInitialState(
        isReady: true,
        isAuthenticated: false,
        user: AuthenticatedUserModel.empty(),
      ));
    });

    on<OnUserSkipStartWizardEvent>((event, emit) {
      emit((state as AuthenticationInitialState).copyWith(
        startWithWizard: false,
      ));
    });
  }
}

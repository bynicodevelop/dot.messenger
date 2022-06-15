import 'package:bloc/bloc.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'start_wizard_event.dart';
part 'start_wizard_state.dart';

class StartWizardBloc extends Bloc<StartWizardEvent, StartWizardState> {
  final UserRepository userRepository;

  StartWizardBloc({
    required this.userRepository,
  }) : super(StartWizardInitialState()) {
    on<OnStartWizardUpdateUsernameEvent>((event, emit) async {
      emit(StartWizardLoadingState());

      try {
        await userRepository.updateProfile({
          'username': event.username,
        });

        emit(StartWizardUpdateUsernameSuccessState());
      } catch (error) {
        emit(
          StartWizardErrorState(
            error: error.toString(),
          ),
        );
      }
    });
  }
}

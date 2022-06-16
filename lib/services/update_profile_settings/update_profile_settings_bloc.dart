import 'package:bloc/bloc.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'update_profile_settings_event.dart';
part 'update_profile_settings_state.dart';

class UpdateProfileSettingsBloc
    extends Bloc<UpdateProfileSettingsEvent, UpdateProfileSettingsState> {
  final UserRepository userRepository;

  UpdateProfileSettingsBloc({
    required this.userRepository,
  }) : super(UpdateProfileSettingsInitialState()) {
    on<OnUpdateProfileSettingsEvent>((event, emit) async {
      emit(UpdateProfileSettingsLoadingState());

      try {
        await userRepository.updateProfile({
          "username": event.username,
          "email": event.email,
          "description": event.description,
        });

        emit(UpdateProfileSettingsSuccessState());
      } catch (e) {
        emit(UpdateProfileSettingsFailureState(
          error: e.toString(),
        ));
      }
    });
  }
}

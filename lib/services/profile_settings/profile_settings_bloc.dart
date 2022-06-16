import 'package:bloc/bloc.dart';
import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  final UserRepository userRepository;

  ProfileSettingsBloc({
    required this.userRepository,
  }) : super(ProfileSettingsInitialState(
          user: AuthenticatedUserModel.empty(),
        )) {
    on<OnLoadProfileSettingsEvent>(((event, emit) async {
      // emit(ProfileSettingsLoadingState());

      try {
        AuthenticatedUserModel user = await userRepository.authenticatedProfile;

        emit(ProfileSettingsInitialState(
          user: user,
          refresh: DateTime.now().millisecond,
        ));
      } catch (e) {
        print(e);
        // emit(ProfileSettingsFailureState(
        //   error: e.toString(),
        // ));
      }
    }));
  }
}

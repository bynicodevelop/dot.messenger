part of 'profile_settings_bloc.dart';

abstract class ProfileSettingsState extends Equatable {
  const ProfileSettingsState();

  @override
  List<Object> get props => [];
}

class ProfileSettingsInitialState extends ProfileSettingsState {
  final int refresh;
  final AuthenticatedUserModel user;

  const ProfileSettingsInitialState({
    required this.user,
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        user,
        refresh,
      ];
}

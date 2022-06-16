part of 'update_profile_settings_bloc.dart';

abstract class UpdateProfileSettingsState extends Equatable {
  const UpdateProfileSettingsState();

  @override
  List<Object> get props => [];
}

class UpdateProfileSettingsInitialState extends UpdateProfileSettingsState {}

class UpdateProfileSettingsLoadingState extends UpdateProfileSettingsState {}

class UpdateProfileSettingsSuccessState extends UpdateProfileSettingsState {}

class UpdateProfileSettingsFailureState extends UpdateProfileSettingsState {
  final String error;

  const UpdateProfileSettingsFailureState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}

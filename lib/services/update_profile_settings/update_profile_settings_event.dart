part of 'update_profile_settings_bloc.dart';

abstract class UpdateProfileSettingsEvent extends Equatable {
  const UpdateProfileSettingsEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateProfileSettingsEvent extends UpdateProfileSettingsEvent {
  final String username;
  final String email;
  final String description;

  const OnUpdateProfileSettingsEvent({
    required this.username,
    required this.email,
    required this.description,
  });

  @override
  List<Object> get props => [
        username,
        email,
        description,
      ];
}

part of 'avatar_edit_button_bloc.dart';

abstract class AvatarEditButtonState extends Equatable {
  const AvatarEditButtonState();

  @override
  List<Object> get props => [];
}

class AvatarEditButtonInitialState extends AvatarEditButtonState {}

class AvatarEditButtonLoadingState extends AvatarEditButtonState {}

class AvatarEditButtonSuccessState extends AvatarEditButtonState {
  final String avatar;

  const AvatarEditButtonSuccessState({
    required this.avatar,
  });

  @override
  List<Object> get props => [
        avatar,
      ];
}

class AvatarEditButtonFailureState extends AvatarEditButtonState {
  final String error;

  const AvatarEditButtonFailureState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}

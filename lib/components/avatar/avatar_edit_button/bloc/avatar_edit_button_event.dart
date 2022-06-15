part of 'avatar_edit_button_bloc.dart';

abstract class AvatarEditButtonEvent extends Equatable {
  const AvatarEditButtonEvent();

  @override
  List<Object> get props => [];
}

class OnTakePhotoEvent extends AvatarEditButtonEvent {}

class OnSelectPhotoEvent extends AvatarEditButtonEvent {}

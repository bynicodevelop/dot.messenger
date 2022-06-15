part of 'avatar_bloc.dart';

abstract class AvatarEvent extends Equatable {
  const AvatarEvent();

  @override
  List<Object> get props => [];
}

class OnAvatarUpdatedEvent extends AvatarEvent {
  final String avatar;

  const OnAvatarUpdatedEvent({
    required this.avatar,
  });

  @override
  List<Object> get props => [
        avatar,
      ];
}

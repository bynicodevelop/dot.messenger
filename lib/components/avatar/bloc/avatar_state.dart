part of 'avatar_bloc.dart';

abstract class AvatarState extends Equatable {
  const AvatarState();

  @override
  List<Object> get props => [];
}

class AvatarInitialState extends AvatarState {
  final String avatar;

  const AvatarInitialState({
    this.avatar = "",
  });

  @override
  List<Object> get props => [
        avatar,
      ];
}

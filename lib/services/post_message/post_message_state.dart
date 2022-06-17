part of 'post_message_bloc.dart';

abstract class PostMessageState extends Equatable {
  const PostMessageState();

  @override
  List<Object> get props => [];
}

class PostMessageInitialState extends PostMessageState {}

class PostMessageLoadingState extends PostMessageState {}

class PostMessageLoadedState extends PostMessageState {
  final String message;

  const PostMessageLoadedState({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

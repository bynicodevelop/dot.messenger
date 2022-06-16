part of 'connect_user_bloc.dart';

abstract class ConnectUserEvent extends Equatable {
  const ConnectUserEvent();

  @override
  List<Object> get props => [];
}

class OnConnectUserEvent extends ConnectUserEvent {
  final String uid;

  const OnConnectUserEvent({
    required this.uid,
  });

  @override
  List<Object> get props => [
        uid,
      ];
}

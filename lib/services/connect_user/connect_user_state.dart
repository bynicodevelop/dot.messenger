part of 'connect_user_bloc.dart';

abstract class ConnectUserState extends Equatable {
  const ConnectUserState();

  @override
  List<Object> get props => [];
}

class ConnectUserInitial extends ConnectUserState {}

class ConnecterUserState extends ConnectUserState {
  final ProfileModel profileModel;

  const ConnecterUserState({
    required this.profileModel,
  });

  @override
  List<Object> get props => [
        profileModel,
      ];
}

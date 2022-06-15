part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class OnUserAuthenticatedEvent extends AuthenticationEvent {
  final AuthenticatedUserModel user;

  const OnUserAuthenticatedEvent({
    required this.user,
  });

  @override
  List<Object> get props => [
        user,
      ];
}

class OnUserSkipStartWizardEvent extends AuthenticationEvent {}

class OnUserUnAuthenticatedEvent extends AuthenticationEvent {}

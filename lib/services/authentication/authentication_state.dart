part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {
  final AuthenticatedUserModel user;
  final bool isReady;
  final bool isAuthenticated;
  final bool startWithWizard;

  const AuthenticationInitialState({
    required this.user,
    this.isReady = false,
    this.isAuthenticated = false,
    this.startWithWizard = false,
  });

  AuthenticationInitialState copyWith({
    AuthenticatedUserModel? user,
    bool? isReady,
    bool? isAuthenticated,
    bool? startWithWizard,
  }) {
    return AuthenticationInitialState(
      user: user ?? this.user,
      isReady: isReady ?? this.isReady,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      startWithWizard: startWithWizard ?? this.startWithWizard,
    );
  }

  @override
  List<Object> get props => [
        isReady,
        isAuthenticated,
        startWithWizard,
        user,
      ];
}

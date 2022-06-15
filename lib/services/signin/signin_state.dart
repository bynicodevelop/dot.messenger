part of 'signin_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {}

class SignInFailureState extends SignInState {
  final String error;

  const SignInFailureState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}

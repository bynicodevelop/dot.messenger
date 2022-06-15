part of 'signup_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignUpState {}

class SignupLoadingState extends SignUpState {}

class SignupSuccessState extends SignUpState {}

class SignupFailureState extends SignUpState {
  final String error;

  const SignupFailureState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}

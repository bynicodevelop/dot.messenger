part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class OnSignupButtonPressedEvent extends SignupEvent {
  final String email;
  final String password;

  const OnSignupButtonPressedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

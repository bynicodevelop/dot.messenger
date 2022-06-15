import 'package:bloc/bloc.dart';
import 'package:dot_messenger/exceptions/user_repository_exception.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  final UserRepository userRepository;

  SignUpBloc({
    required this.userRepository,
  }) : super(SignupInitialState()) {
    on<OnSignupButtonPressedEvent>((event, emit) async {
      emit(SignupLoadingState());

      try {
        await userRepository.createAccount({
          'email': event.email,
          'password': event.password,
        });

        emit(SignupSuccessState());
      } on UserRepositoryException catch (e) {
        emit(SignupFailureState(
          error: e.message,
        ));
      }
    });
  }
}

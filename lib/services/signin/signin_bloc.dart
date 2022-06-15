import 'package:bloc/bloc.dart';
import 'package:dot_messenger/exceptions/user_repository_exception.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;

  SignInBloc({
    required this.userRepository,
  }) : super(SignInInitialState()) {
    on<OnSignInEvent>((event, emit) async {
      emit(SignInLoadingState());

      try {
        await userRepository.login({
          "email": event.email,
          "password": event.password,
        });

        emit(SignInSuccessState());
      } on UserRepositoryException catch (e) {
        emit(SignInFailureState(
          error: e.message,
        ));
      }
    });
  }
}

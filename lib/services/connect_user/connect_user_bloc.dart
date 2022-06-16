import 'package:bloc/bloc.dart';
import 'package:dot_messenger/models/profile_model.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'connect_user_event.dart';
part 'connect_user_state.dart';

class ConnectUserBloc extends Bloc<ConnectUserEvent, ConnectUserState> {
  final UserRepository userRepository;

  ConnectUserBloc({
    required this.userRepository,
  }) : super(ConnectUserInitial()) {
    on<OnConnectUserEvent>((event, emit) async {
      // TODO: ajouter le try catch
      final ProfileModel profileModel = await userRepository.connectUser({
        "uid": event.uid,
      });

      emit(ConnecterUserState(
        profileModel: profileModel,
      ));
    });
  }
}

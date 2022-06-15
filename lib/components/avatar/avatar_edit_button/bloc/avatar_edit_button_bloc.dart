import 'package:bloc/bloc.dart';
import 'package:dot_messenger/repositories/image_repository.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'avatar_edit_button_event.dart';
part 'avatar_edit_button_state.dart';

class AvatarEditButtonBloc
    extends Bloc<AvatarEditButtonEvent, AvatarEditButtonState> {
  final UserRepository userRepository;
  final ImageRepository imageRepository;

  AvatarEditButtonBloc({
    required this.userRepository,
    required this.imageRepository,
  }) : super(AvatarEditButtonInitialState()) {
    on<OnTakePhotoEvent>((event, emit) async {
      final String? file = await imageRepository.takePhoto();

// TODO: Tester le cas où l'utilisateur n'a pas choisi de photo
      await userRepository.updateProfile({
        "avatar": file,
      });
    });

    on<OnSelectPhotoEvent>((event, emit) async {
      emit(AvatarEditButtonLoadingState());

      try {
        final String? file = await imageRepository.selectPhoto();

        // TODO: Tester le cas où l'utilisateur n'a pas choisi de photo
        await userRepository.updateProfile({
          "avatar": file,
        });

        emit(AvatarEditButtonSuccessState(
          avatar: file!,
        ));
      } catch (e) {
        emit(AvatarEditButtonFailureState(
          error: e.toString(),
        ));
      }
    });
  }
}

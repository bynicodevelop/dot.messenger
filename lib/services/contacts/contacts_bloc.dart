import 'package:bloc/bloc.dart';
import 'package:dot_messenger/models/profile_model.dart';
import 'package:dot_messenger/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final UserRepository userRepository;

  ContactsBloc({
    required this.userRepository,
  }) : super(const ContactsInitialState(profiles: [])) {
    on<OnLoadContactsEvent>((event, emit) async {
      final List<ProfileModel> contacts = await userRepository.contacts;

      emit(ContactsInitialState(
        profiles: contacts,
      ));
    });
  }
}

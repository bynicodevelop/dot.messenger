part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsInitialState extends ContactsState {
  final List<ProfileModel> profiles;

  const ContactsInitialState({
    required this.profiles,
  });

  @override
  List<Object> get props => [
        profiles,
      ];
}

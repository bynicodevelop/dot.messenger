import 'package:dot_messenger/components/avatar/avatar_component.dart';
import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/models/profile_model.dart';
import 'package:dot_messenger/responsive.dart';
import 'package:dot_messenger/screens/message_creator_screen.dart';
import 'package:dot_messenger/services/contacts/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatelessWidget {
  final AuthenticatedUserModel authenticatedUserModel;

  const ContactScreen({
    Key? key,
    required this.authenticatedUserModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      bloc: context.read<ContactsBloc>()..add(OnLoadContactsEvent()),
      builder: (context, state) {
        final List<ProfileModel> contacts =
            (state as ContactsInitialState).profiles;

        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 8.0,
          ),
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            final ProfileModel contact = contacts[index];

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageCreatorScreen(
                      isMobile: Responsive.isMobile(context),
                      chatModel: ChatModel(
                        authenticatedUserId: authenticatedUserModel.uid,
                        peerId: contact.uid,
                        profile: contact,
                        lastMessage: "",
                        // TODO: pas top !
                        updatedAt: DateTime.now(),
                      ),
                    ),
                  ),
                ),
                leading: Hero(
                  tag: contact.uid,
                  child: AvatarComponent(
                    disabledAnchor: true,
                    avatarFromProfile: contact.avatar,
                    size: 25,
                  ),
                ),
                title: Text(
                  contact.username,
                  style: Theme.of(context).textTheme.headline4!,
                ),
                subtitle: Row(
                  children: [
                    Flexible(
                      child: Text(
                        contact.description,
                        style: Theme.of(context).textTheme.subtitle1!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 16.0,
            );
          },
        );
      },
    );
  }
}

import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/screens/message_creator_screen.dart';
import 'package:dot_messenger/services/authentication/authentication_bloc.dart';
import 'package:dot_messenger/services/connect_user/connect_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeepLinkScreen extends StatelessWidget {
  final String uid;

  const DeepLinkScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final AuthenticatedUserModel authenticatedUserModel =
            (state as AuthenticationInitialState).user;

        return BlocBuilder<ConnectUserBloc, ConnectUserState>(
          bloc: context.read<ConnectUserBloc>()
            ..add(
              OnConnectUserEvent(
                uid: uid,
              ),
            ),
          builder: (context, state) {
            if (state is ConnecterUserState) {
              return MessageCreatorScreen(
                chatModel: ChatModel(
                  authenticatedUserId: authenticatedUserModel.uid,
                  peerId: uid,
                  profile: state.profileModel,
                  lastMessage: "",
                  // TOOD: pas top !
                  updatedAt: DateTime.now(),
                ),
              );
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}

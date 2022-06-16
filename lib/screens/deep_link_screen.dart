import 'package:dot_messenger/screens/message_creator_screen.dart';
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
            profileModel: state.profileModel,
          );
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

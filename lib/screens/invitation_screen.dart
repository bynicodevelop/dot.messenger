import 'package:dot_messenger/components/invitation_buttons/invitation_buttons_component.dart';
import 'package:flutter/material.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitez vos contacts'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 32.0,
        ),
        child: InvitationButtonComponent(),
      ),
    );
  }
}

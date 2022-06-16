import 'package:dot_messenger/config/constant.dart';
import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/services/profile_settings/profile_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InvitationButtonComponent extends StatelessWidget {
  const InvitationButtonComponent({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSettingsBloc, ProfileSettingsState>(
      bloc: context.read<ProfileSettingsBloc>()
        ..add(OnLoadProfileSettingsEvent()),
      builder: (context, state) {
        final AuthenticatedUserModel user =
            (state as ProfileSettingsInitialState).user;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 22.0,
              ),
              child: Text(
                "Pourquoi ne pas commencer par inviter des amis ?",
                style: Theme.of(context).textTheme.headline2!,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  color: kDefaultBubble,
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                      text: "dot://dotmessenger.com/connect/${user.uid}",
                    ));
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.link,
                    size: 28.0,
                  ),
                ),
                IconButton(
                  color: kDefaultBubble,
                  onPressed: () {
                    final String message = "Bonjour 👋,\n\n"
                        "Je t'invite à me rejoindre sur Dot Messenger, une application de messagerie.\n\n"
                        "dot://dotmessenger.com/connect/${user.uid}";

                    _launchUrl("sms://?&body=${Uri.encodeFull(message)}");
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.commentSms,
                    size: 28.0,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

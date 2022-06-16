import 'package:dot_messenger/components/invitation_buttons/invitation_buttons_component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagesListScreen extends StatelessWidget {
  final bool isMobile;
  final List<Map<String, dynamic>> messages;
  final Function(Map<String, dynamic>) onMessageTap;

  const MessagesListScreen({
    Key? key,
    this.isMobile = false,
    required this.messages,
    required this.onMessageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return messages.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 28.0 : 0.0,
              vertical: 8.0,
            ),
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: ListTile(
                  onTap: () => onMessageTap(messages[index]),
                  leading: Hero(
                    tag: messages[index]["profile"].uid,
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        messages[index]["profile"].avatar,
                      ),
                    ),
                  ),
                  title: Text(
                    messages[index]["profile"].username,
                    style: Theme.of(context).textTheme.headline4!,
                  ),
                  subtitle: Row(
                    children: [
                      if (messages[index]["readed"] == true)
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 2.0,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.checkDouble,
                            size: 12.0,
                          ),
                        ),
                      Flexible(
                        child: Text(
                          messages[index]["message"],
                          style: Theme.of(context).textTheme.subtitle1!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        timeago.format(messages[index]["time"],
                            locale: 'en_short'),
                        style: Theme.of(context).textTheme.caption!,
                      ),
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
          )
        : const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32.0,
            ),
            child: InvitationButtonComponent(),
          );
  }
}

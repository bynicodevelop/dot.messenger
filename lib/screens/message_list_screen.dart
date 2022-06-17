import 'package:dot_messenger/components/avatar/avatar_component.dart';
import 'package:dot_messenger/components/invitation_buttons/invitation_buttons_component.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/services/list_chat/list_chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagesListScreen extends StatelessWidget {
  final bool isMobile;
  final List<Map<String, dynamic>> messages;
  final Function(ChatModel) onMessageTap;

  const MessagesListScreen({
    Key? key,
    this.isMobile = false,
    required this.messages,
    required this.onMessageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListChatBloc, ListChatState>(
        bloc: context.read<ListChatBloc>()..add(OnListChatEvent()),
        builder: (context, state) {
          final List<ChatModel> chatModels =
              (state as ListChatInitialState).chatModel;

          return chatModels.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 28.0 : 0.0,
                    vertical: 8.0,
                  ),
                  itemCount: chatModels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        onTap: () => onMessageTap(chatModels[index]),
                        leading: Hero(
                          tag: chatModels[index].id,
                          child: AvatarComponent(
                            avatarFromProfile: chatModels[index].profile.avatar,
                            disabledAnchor: true,
                            size: 22.0,
                          ),
                        ),
                        title: Text(
                          chatModels[index].profile.username,
                          style: Theme.of(context).textTheme.headline4!,
                        ),
                        subtitle: Row(
                          children: [
                            // if (messages[index]["readed"] == true)
                            //   const Padding(
                            //     padding: EdgeInsets.only(
                            //       right: 2.0,
                            //     ),
                            //     child: FaIcon(
                            //       FontAwesomeIcons.checkDouble,
                            //       size: 12.0,
                            //     ),
                            //   ),
                            Flexible(
                              child: Text(
                                chatModels[index].lastMessage,
                                // messages[index]["message"],
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
                              timeago.format(
                                chatModels[index].updatedAt,
                                locale: 'en_short',
                              ),
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
        });
  }
}

import 'package:dot_messenger/components/avatar/avatar_component.dart';
import 'package:dot_messenger/components/message_form/mobile_message_form_component.dart';
import 'package:dot_messenger/config/constant.dart';
import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/models/chat_model.dart';
import 'package:dot_messenger/models/message_model.dart';
import 'package:dot_messenger/services/authentication/authentication_bloc.dart';
import 'package:dot_messenger/services/list_message/list_message_bloc.dart';
import 'package:dot_messenger/widgets/mobile_messenger_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

final List<Map<String, dynamic>> messages = [
  // {
  //   'id': '120',
  //   'text': 'Hello there!',
  //   'author': true,
  //   'uid': '1',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '121',
  //   'text': 'Hello',
  //   'author': false,
  //   'uid': '2',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '122',
  //   'text': 'lorem ipsum dolor sit amet',
  //   'author': true,
  //   'uid': '1',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '123',
  //   'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
  //   'author': false,
  //   'uid': '2',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '120',
  //   'text': 'Hello there!',
  //   'author': true,
  //   'uid': '1',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '120',
  //   'text': 'Hello there!',
  //   'author': true,
  //   'uid': '1',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '121',
  //   'text': 'Hello',
  //   'author': false,
  //   'uid': '2',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '122',
  //   'text': 'lorem ipsum dolor sit amet',
  //   'author': true,
  //   'uid': '1',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '123',
  //   'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
  //   'author': false,
  //   'uid': '2',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '123',
  //   'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
  //   'author': false,
  //   'uid': '2',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '122',
  //   'text': 'lorem ipsum dolor sit amet',
  //   'author': true,
  //   'uid': '1',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '123',
  //   'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
  //   'author': false,
  //   'uid': '2',
  //   'time': DateTime.now(),
  // },
  // {
  //   'id': '123',
  //   'text': 'lorem ipsum dolor sit amet, consectetur adipiscing elit',
  //   'author': false,
  //   'uid': '2',
  //   'time': DateTime.now(),
  // },
];

class MessageCreatorScreen extends StatelessWidget {
  final bool isMobile;
  final ChatModel chatModel;

  final double _height = 110.0;

  const MessageCreatorScreen({
    Key? key,
    this.isMobile = false,
    required this.chatModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileMessengerAppBarWidget(
        avatar: Hero(
          tag: chatModel.id,
          child: AvatarComponent(
            disabledAnchor: true,
            avatarFromProfile: chatModel.profile.avatar,
            size: 20,
          ),
        ),
        username: chatModel.profile.username,
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          final AuthenticatedUserModel user =
              (state as AuthenticationInitialState).user;

          return BlocBuilder<ListMessageBloc, ListMessageState>(
            bloc: context.read<ListMessageBloc>()
              ..add(
                OnLoadListMessage(
                  chatModel: chatModel,
                ),
              ),
            builder: (context, state) {
              final List<MessageModel> messages =
                  (state as ListMessageInitialState).messages;

              return Stack(
                children: [
                  messages.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                            bottom: _height,
                            left: isMobile
                                ? 0
                                : MediaQuery.of(context).size.width * .1,
                            right: isMobile
                                ? 0
                                : MediaQuery.of(context).size.width * .1,
                          ),
                          child: ListView.separated(
                            reverse: true,
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 5.0,
                            ),
                            shrinkWrap: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  left: messages[index].author == user.uid
                                      ? MediaQuery.of(context).size.width *
                                          (isMobile ? .3 : .2)
                                      : 22.0,
                                  right: messages[index].author == user.uid
                                      ? 22.0
                                      : MediaQuery.of(context).size.width *
                                          (isMobile ? .3 : .2),
                                  bottom: 5.0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: messages[index].author == user.uid
                                      ? kDefaultBubble
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      messages[index].author == user.uid
                                          ? 10.0
                                          : 0,
                                    ),
                                    topRight: const Radius.circular(
                                      10.0,
                                    ),
                                    bottomLeft: const Radius.circular(
                                      10.0,
                                    ),
                                    bottomRight: Radius.circular(
                                      messages[index].author == user.uid
                                          ? 0
                                          : 10.0,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      messages[index].author == user.uid
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        messages[index].message,
                                        style: TextStyle(
                                          color:
                                              messages[index].author == user.uid
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return messages[index].author ==
                                      messages[index + 1].author
                                  ? const SizedBox(
                                      height: 0.0,
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        left: messages[index].author != user.uid
                                            ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    (isMobile ? .3 : .2) +
                                                12.0
                                            : 32.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            timeago.format(
                                              messages[index].time,
                                              locale: 'en',
                                            ),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          )
                                        ],
                                      ),
                                    );
                            },
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                (MediaQuery.of(context).size.width * .4) / 2,
                            vertical: MediaQuery.of(context).size.height * .1,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          height: 200.0,
                          width: MediaQuery.of(context).size.width * .6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Text(
                                  'No messages yet',
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Text(
                                  'Start chatting with your friends',
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Text(
                                "👋",
                                style: TextStyle(
                                  fontSize: 50.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MobileMessageFormComponent(
                      chatModel: chatModel,
                      height: _height,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
